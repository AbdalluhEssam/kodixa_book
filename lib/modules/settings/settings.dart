import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/post_model.dart';
import 'package:kodixa_book/modules/edit_profile/edit_profile.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

import '../feeds/Feeds.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics:const  BouncingScrollPhysics(),
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
                                alignment: const AlignmentDirectional(0, -1),
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
                            onPressed: () {}, child: const Text('Add Photo'))),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, const EditProfileScreen());
                        },
                        child: const Icon(IconBroken.Edit)),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.postOnly.length,
                itemBuilder: (context, index) =>
                    buildPostItem(PostModel.fromJson(cubit.postOnly[index]),cubit.usersPosts[index] ,context, index),
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
