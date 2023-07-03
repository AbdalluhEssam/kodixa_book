// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
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
      print(value.data());
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
      name: userModel!.name,
      image: userModel!.image,
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
  List<String> likesUID = [];
  List<bool> likeIs = [];

  void addLike(index, bool like) {
    likeIs[index] = like;
    if (like == true) {
      likes.replaceRange(index, index + 1, [1]);
      emit(SocialPlusLikePostSuccessState());
    } else {
      likes.replaceRange(index, index + 1, [0]);

      emit(SocialMinLikePostSuccessState());
    }

    emit(SocialAddLikePostSuccessState());
  }

  void getPost() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          for (var element in value.docs) {
            likesUID.add(element.reference.id);
            likeIs.add(true);
          }
          if (posts.length != likesUID.length) {
            likesUID.add("null");
            likeIs.add(false);
          }
          print(likes);
        }).catchError((onError) {
          print(onError);
        });
      }
      getAllUsers();
      emit(SocialGetPostSuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialGetPostErrorState(onError));
    });
  }

  void likePost(String postId, index) {
    // emit(SocialLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({"like": true}).then((value) {
      // getPost();
      emit(SocialLikePostSuccessState());
      addLike(index, true);
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialLikePostErrorState(onError));
    });
  }

  void unLikePost(String postId, index) {
    // emit(SocialLikePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      // getPost();
      emit(SocialUnLikePostSuccessState());
      addLike(index, false);
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialUnLikePostErrorState(onError));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUserLoadingState());
    if(users.isEmpty){
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != userModel!.uId){
            users.add(UserModel.fromJson(element.data()));
          }

        });
        getOnlyPost();
        emit(SocialGetAllUserSuccessState());
      }).catchError((onError) {
        print("Error is $onError");
        emit(SocialGetAllUserErrorState(onError));
      });
    }

  }

  List<dynamic> postOnly = [];
  int countPost = 0;
  int countPhotoPost = 0;

  void getOnlyPost() {
    emit(SocialGetPostOnlyLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        if(element['uId'] == userModel!.uId){
          postOnly.add(element.data());
          countPost++;
          if(element['postImage'] != ''){
            countPhotoPost++;
          }
        }

      }
      print(postOnly);
      emit(SocialGetPostOnlySuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(SocialGetPostOnlyErrorState(onError));
    });
  }
}
