import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/post_model.dart';
import 'package:kodixa_book/modules/edit_profile/edit_profile.dart';
import 'package:kodixa_book/modules/login/login.dart';
import 'package:kodixa_book/modules/new_posts/new_posts.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';
import '../../models/user_model.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return RefreshIndicator(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                // alignment: const AlignmentDirectional(0, -1),
                                image: CachedNetworkImageProvider(
                                    cubit.userModel!.cover.toString()))),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        radius: 51,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: CachedNetworkImageProvider(
                              cubit.userModel!.image.toString()),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                cubit.userModel!.name.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                cubit.userModel!.bio.toString(),
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${cubit.countPost}",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${cubit.countPhotoPost}",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Photos",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "800",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              navigateTo(context, const NewPostsScreen());
                            }, child: const Text('Add Photo'))),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, const EditProfileScreen());
                        },
                        child: const Icon(IconBroken.Edit)),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          CacheHelper.sharedPreferences!.clear();
                          navigateTo(context, const LohInScreen());
                        },
                        child: const Icon(IconBroken.Logout)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            FirebaseMessaging.instance.subscribeToTopic("chats");
                          },
                          child: Row(
                            children: const [
                              Icon(IconBroken.Notification),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Subscribe"),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              FirebaseMessaging.instance.unsubscribeFromTopic("chats");

                            },
                            child: Row(
                              children: const [
                                Icon(Icons.notifications_off_outlined),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("UnSubscribe"),
                              ],
                            ))),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if(cubit.usersPostOnly.isNotEmpty && cubit.postOnly.isNotEmpty)
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.postOnly.length,
                  itemBuilder: (context, index) => buildPostItemOnly(
                      PostModel.fromJson(cubit.postOnly[index]),
                      cubit.usersPostOnly[index],
                      context,
                      index),
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 10,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ), onRefresh: ()async{
          cubit.getPostOnly();
        });
      },
    );
  }
}
Widget buildPostItemOnly(PostModel model, UserModel userModel, context, index) =>
    Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(userModel.image!),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(userModel.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: 1.4)),
                            const SizedBox(
                              width: 5,
                            ),
                            if(userModel.uId == "FpyOUSvnANhvIPrwdfIUdpu3pUX2")

                              const Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                            DateFormat('d MMMM y  hh:mm:a', 'en_US')
                                .format(DateTime.parse(model.dateTime!)),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4)),
                      ],
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              padding: const EdgeInsets.only(top: 3, bottom: 8),
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5),
                    child: SizedBox(
                      height: 20,
                      child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20,
                          onPressed: () {},
                          child: Text(
                            "#software",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5),
                    child: SizedBox(
                      height: 20,
                      child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          height: 20,
                          onPressed: () {},
                          child: Text(
                            "#flutter",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageUrl: model.postImage!,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              // if(SocialCubit.get(context).likesUID[index].keys.contains(SocialCubit.get(context).postsId[index]))
                              SocialCubit.get(context).likesUIDPostOnly[index] == true
                                  ? const Icon(
                                Icons.favorite,
                                size: 20,
                                color: Colors.red,
                              )
                                  : const Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocialCubit.get(context).likesPostOnly[index]}",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialCubit.get(context).getCommentOnly(
                              postId: SocialCubit.get(context).postsIdOnly[index]);

                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                height: 500,
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                child: SocialCubit.get(context).commentPostOnly.isNotEmpty &&SocialCubit.get(context).usersCommentPostOnly.isNotEmpty
                                    ? ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                            CachedNetworkImageProvider(
                                                SocialCubit.get(context)
                                                    .usersCommentPostOnly[index]
                                                    .image!),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        SocialCubit.get(
                                                            context)
                                                            .usersCommentPostOnly[
                                                        index]
                                                            .name!,
                                                        style:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .subtitle1!),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Icon(
                                                      Icons.check_circle,
                                                      color: defaultColor,
                                                      size: 16,
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                        DateFormat(
                                                            'd MMMM y  hh:mm:a',
                                                            'en_US')
                                                            .format(DateTime.parse(
                                                            SocialCubit.get(
                                                                context)
                                                                .commentPostOnly[
                                                            index]
                                                            [
                                                            'dateTime']
                                                                .toString())),
                                                        style:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                            height:
                                                            1.4)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  SocialCubit.get(context)
                                                      .commentPostOnly[index]['text']
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      height: 1.4),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  itemCount:
                                  SocialCubit.get(context).commentPostOnly.length,
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                                )
                                    : Center(
                                  child: Text('There Are No Comments',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(height: 1.4)),
                                )),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 20,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocialCubit.get(context).commentCountPostOnly[index]} Comment",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: 450,
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30),
                              child: Form(
                                key: SocialCubit.get(context).formKeyComment,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: defaultTextFormField(
                                          controller: SocialCubit.get(context)
                                              .textCommentController,
                                          keyboardType: TextInputType.text,
                                          labelText: 'Comment',
                                          icon: IconBroken.Message,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Comment';
                                            }
                                            return null;
                                          }),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context).sendComment(
                                            index: index,
                                              postId: SocialCubit.get(context)
                                                  .postsIdOnly[index],
                                              dateTime: DateTime.now().toString(),
                                              text: SocialCubit.get(context)
                                                  .textCommentController
                                                  .text);
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(IconBroken.Send))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                  SocialCubit.get(context).userModel!.image!),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "write a comment ...",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      if (SocialCubit.get(context).likesUIDPostOnly[index] == false) {
                        SocialCubit.get(context).likePost(
                            SocialCubit.get(context).postsIdOnly[index], index);
                      } else {
                        SocialCubit.get(context).unLikePost(
                            SocialCubit.get(context).postsIdOnly[index], index);
                      }
                    },
                    child: Row(
                      children: [
                        SocialCubit.get(context).likesUIDPostOnly[index] == true
                            ? const Icon(
                          Icons.favorite,
                          size: 25,
                          color: Colors.red,
                        )
                            : const Icon(
                          IconBroken.Heart,
                          size: 25,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );