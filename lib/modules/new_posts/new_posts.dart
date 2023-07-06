import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

class NewPostsScreen extends StatelessWidget {
  const NewPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: "Create Post", actions: [
            defaultTextButton(
                onPressed: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        text: cubit.postController.text,
                        dateTime: DateTime.now().toString());
                    Navigator.pop(context);
                  } else {
                    cubit.uploadPostImage(
                        text: cubit.postController.text,
                        dateTime: DateTime.now().toString());
                    Navigator.pop(context);
                  }

                },
                text: "Post")
          ]),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Add Photo")
                          ],
                        ))),
                Expanded(
                    child: TextButton(
                        onPressed: () {}, child: const Text("# tags"))),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: CachedNetworkImageProvider(cubit.userModel!.image!),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(cubit.userModel!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(height: 1.4))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 1000,
                    controller: cubit.postController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind,',
                      border: InputBorder.none,
                    ),
                  ),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  // fit: BoxFit.cover,
                                  image: FileImage(cubit.postImage!))),
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.getCoverImage();
                            },
                            icon: const CircleAvatar(
                              radius: 20,
                              // backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
