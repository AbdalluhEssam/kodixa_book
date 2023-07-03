import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/post_model.dart';
import 'package:kodixa_book/shared/styles/colors.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.posts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image.network(
                            "https://instagram.fcai19-7.fna.fbcdn.net/v/t51.2885-19/334093423_932091597840436_2935192682114262128_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fcai19-7.fna.fbcdn.net&_nc_cat=104&_nc_ohc=zekpAVWToKcAX_Pa4AC&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfAqcVbQ4Nhx366jDR_4JP-aU3e7xihvTfh8atz-W9mBWQ&oe=64A6FEB4&_nc_sid=8b3546",
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Communicate with friends",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.posts.length,
                      itemBuilder: (context, index) =>
                          buildPostItem(cubit.posts[index], context, index),
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
              );
      },
    );
  }
}

Widget buildPostItem(PostModel model, context, index) => Card(
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
                  backgroundImage: CachedNetworkImageProvider(model.image!),
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
                        Text(model.name!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(height: 1.4)),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16,
                        )
                      ],
                    ),
                    Text(model.dateTime!,
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
                          SocialCubit.get(context).likeIs[index] == true
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
                            SocialCubit.get(context).likes[index] != null
                                ? "${SocialCubit.get(context).likes[index]}"
                                : "0",
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
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
                            "120 Comment",
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
                    onTap: () {},
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
                      if (SocialCubit.get(context)
                          .likesUID[index]
                          .contains(SocialCubit.get(context).userModel!.uId!)) {
                        SocialCubit.get(context).unLikePost(
                            SocialCubit.get(context).postsId[index], index);
                      } else {
                        SocialCubit.get(context).likePost(
                            SocialCubit.get(context).postsId[index], index);
                      }
                    },
                    child: Row(
                      children: [
                        SocialCubit.get(context).likeIs[index] == true
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
// cubit.model != null
// ? Column(
// children: [
// if (!FirebaseAuth.instance.currentUser!.emailVerified == false)
// Container(
// padding: const EdgeInsets.symmetric(horizontal: 10),
// color: Colors.amber.withOpacity(0.7),
// child: Row(
// children: [
// const Icon(Icons.info_outline),
// const SizedBox(
// width: 8,
// ),
// const Expanded(
// child: Text('please verify your email')),
// const SizedBox(
// width: 20,
// ),
// defaultTextButton(
// text: "send",
// onPressed: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showToast(text: "check Your mail", state: ToastStates.SUCCESS);
// })
//     .catchError((onError) {});
// })
// ],
// ),
// ),
// ],
// )
// : const Center(
// child: CircularProgressIndicator(),
// ),
