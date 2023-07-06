// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/comment_model.dart';
import 'package:kodixa_book/models/massage_model.dart';
import 'package:kodixa_book/models/post_model.dart';
import 'package:kodixa_book/models/user_model.dart';
import 'package:kodixa_book/modules/chats/chats.dart';
import 'package:kodixa_book/modules/feeds/Feeds.dart';
import 'package:kodixa_book/modules/settings/settings.dart';
import 'package:kodixa_book/modules/users/users.dart';
import 'package:kodixa_book/shared/components/constants.dart';
import '../../modules/new_posts/new_posts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  PostModel? postModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController textMassageController = TextEditingController();
  TextEditingController textCommentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKeyComment = GlobalKey<FormState>();
  File? profileImage;
  File? coverImage;
  File? postImage;
  final ImagePicker picker = ImagePicker();

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImageErrorState());
    }
  }

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImageErrorState());
    }
  }

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImageErrorState());
    }
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      print("error is $onError");
      emit(SocialGetUserErrorState(onError));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> title = [
    'News Feed',
    'Chat',
    'Add Post',
    'Users',
    'Profile',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  void uploadProfileImage(
      {required String name,
      required String phone,
      required String bio,
      context}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: name, phone: phone, bio: bio, profile: value.toString());
        print("URL is $value");
        emit(SocialUploadProfileImageSuccessState());
        Navigator.pop(context);
      }).catchError((onError) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage(
      {required String name,
      required String phone,
      required String bio,
      context}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("URL is $value");
        updateUser(name: name, phone: phone, bio: bio, cover: value.toString());
        emit(SocialUploadProfileCoverSuccessState());
        Navigator.pop(context);
      }).catchError((onError) {
        emit(SocialUploadProfileCoverErrorState());
      });
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialUploadProfileCoverErrorState());
    });
  }

  // void updateUserImage() {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (profileImage != null && coverImage != null) {
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   } else {
  //     updateUser();
  //   }
  // }

  void updateUser(
      {String? cover,
      String? profile,
      required String name,
      required String phone,
      required String bio,
      context}) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profile ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
      email: userModel!.email,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      Navigator.pop(context);
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialUserUpdateErrorState());
    });
  }

  void uploadPostImage(
      {required String text, required String dateTime, context}) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("URL is $value");
        emit(SocialCreatePostSuccessState());
        createPost(text: text, dateTime: dateTime, postImage: value.toString());
        Navigator.pop(context);
      }).catchError((onError) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? postImage,
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<bool> likesUID = [];

  List<UserModel> users = [];
  List<UserModel> usersPosts = [];

  void getPost() {
    usersPosts.clear();
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((event) {
      posts.clear();
      postsId.clear();
      likesUID.clear();
      likes.clear();
      commentCount.clear();

      for (var elementt in event.docs) {
        emit(SocialGetPostOnlyLoadingState());
        FirebaseFirestore.instance
            .collection('posts')
            .doc(elementt.reference.id)
            .collection('comments')
            .snapshots()
            .listen((event) {
          commentCount.add(event.docs.length);
          emit(SocialGetCommentSuccessState());
        });
        FirebaseFirestore.instance
            .collection('posts')
            .snapshots()
            .listen((event) {
          postOnly.clear();
          countPost = 0;
          countPhotoPost = 0;
          for (var element in event.docs) {
            if (element['uId'] == userModel!.uId) {
              postOnly.add(element.data());
              countPost++;
              if (element['postImage'] != '') {
                countPhotoPost++;
              }
            }
          }
          emit(SocialGetPostOnlySuccessState());
        });
        posts.add(PostModel.fromJson(elementt.data()));
        postsId.add(elementt.id);

        FirebaseFirestore.instance
            .collection('users')
            .doc(elementt['uId'])
            .snapshots()
            .listen((value) {
          usersPosts.add(UserModel.fromJson(value.data()!));
          emit(SocialGetAllUserSuccessState());
          // getOnlyPost();
        });
        elementt.reference.collection('likes').snapshots().listen((event) {
          likes.add(event.docs.length);
          for (var element in event.docs.reversed) {
            if (userModel!.uId! != element.reference.id) {
              likesUID.add(false);
            }

            if (userModel!.uId! == element.reference.id) {
              likesUID.add(true);
            }
            break;
          }
          print(likesUID);
          emit(SocialLikePostSuccessState());
        });
      }

      getAllUsers();
      emit(SocialGetPostSuccessState());
    });
  }

  void likePost(String postId, index) {
    emit(SocialLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({"like": true}).then((value) {
      likes[index]++;
      likesUID[index] = true;
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialLikePostErrorState(onError));
    });
  }

  void unLikePost(String postId, index) {
    emit(SocialLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      likes[index]--;
      likesUID[index] = false;
      emit(SocialUnLikePostSuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialUnLikePostErrorState(onError));
    });
  }

  void getAllUsers() {
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((event) {
      for (var element in event.docs) {
        if (users.isEmpty) {
          if (element['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
      }
      emit(SocialGetAllUserSuccessState());
      // getOnlyPost();
    }).catchError((onError) {
      emit(SocialGetAllUserErrorState(onError));
    });
  }

  List<dynamic> postOnly = [];
  int countPost = 0;
  int countPhotoPost = 0;

  void sendComment({
    required String postId,
    required String dateTime,
    required String text,
  }) {
    CommentModel model = CommentModel(
      text: text,
      senderId: userModel!.uId,
      postId: postId,
      dateTime: dateTime,
    );

    if (formKeyComment.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add(model.toMap())
          .then((value) {
        emit(SocialSendCommentSuccessState());
      }).catchError((onError) {
        print("Error Is $onError");
        emit(SocialSendCommentErrorState(onError));
      });

      textCommentController.text = '';
    }
  }

  List<dynamic> comment = [];
  List<UserModel> usersComment = [];
  List<int> commentCount = [];

  void getComment({
    required String postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      comment.clear();
      for (var element in event.docs) {
        comment.add(element.data());
        FirebaseFirestore.instance
            .collection('users')
            .doc(element['senderId'])
            .snapshots()
            .listen((value) {
          usersComment.add(UserModel.fromJson(value.data()!));
          emit(SocialGetAllUserSuccessState());
          // getOnlyPost();
        });
      }
      print(usersComment);
      emit(SocialGetCommentSuccessState());
    });
  }

  void sendMassage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MassageModel model = MassageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    if (formKey.currentState!.validate()) {
      //// Sent Me
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((onError) {
        print("Error Is $onError");
        emit(SocialSendMessageErrorState(onError));
      });
      //// Sent receiver
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(userModel!.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((onError) {
        print("Error Is $onError");
        emit(SocialSendMessageErrorState(onError));
      });
      textMassageController.text = '';
    }
  }

  List<MassageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();

      for (var element in event.docs) {
        messages.add(MassageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }
}
