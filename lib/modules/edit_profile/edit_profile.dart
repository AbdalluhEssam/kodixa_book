// ignore_for_file: avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        cubit.nameController.text = cubit.userModel!.name!;
        cubit.bioController.text = cubit.userModel!.bio!;
        cubit.phone.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: "Edit Profile", actions: [
            defaultTextButton(
                onPressed: () {
                  cubit.updateUser(
                      bio: cubit.bioController.text,
                      name: cubit.nameController.text,
                      phone: cubit.phone.text);
                },
                text: "Update"),
            const SizedBox(
              width: 5,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    Column(
                      children: const [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: cubit.coverImage == null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,

                                            image: CachedNetworkImageProvider(
                                                cubit.userModel!.cover
                                                    .toString()))
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                         
                                            image:
                                                FileImage(cubit.coverImage!))),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    // backgroundColor: Colors.white,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 51,
                              child: cubit.profileImage == null
                                  ? CircleAvatar(
                                      radius: 47,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        cubit.userModel!.image.toString(),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 47,
                                      backgroundImage:
                                          FileImage(cubit.profileImage!),
                                    ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  // radius: 20,
                                  // backgroundColor: Colors.white,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  text: "Upload Profile",
                                  onPressed: () {
                                    cubit.uploadProfileImage(
                                        bio: cubit.bioController.text,
                                        name: cubit.nameController.text,
                                        phone: cubit.phone.text,
                                        context: context);
                                  }),
                              if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          )),
                        const SizedBox(
                          width: 8,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  text: "Upload Cover",
                                  onPressed: () {
                                    cubit.uploadCoverImage(
                                        bio: cubit.bioController.text,
                                        name: cubit.nameController.text,
                                        phone: cubit.phone.text,
                                        context: context);
                                  }),
                              if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  defaultTextFormField(
                      controller: cubit.nameController,
                      keyboardType: TextInputType.name,
                      labelText: "Name",
                      icon: IconBroken.User,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: cubit.bioController,
                      keyboardType: TextInputType.text,
                      labelText: "Bio",
                      icon: IconBroken.Info_Circle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: cubit.phone,
                      keyboardType: TextInputType.phone,
                      labelText: "Phone",
                      icon: IconBroken.Call,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
