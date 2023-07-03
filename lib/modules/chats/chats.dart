import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/user_model.dart';
import 'package:kodixa_book/modules/chats_details/chats_details.dart';
import 'package:kodixa_book/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: Container(
              padding: const EdgeInsets.all(5),
              child: cubit.users.isEmpty ?const Center(
                child: CircularProgressIndicator(),
              ) : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.users.length,
                itemBuilder: (context, index) =>
                    buildChatItem(cubit.users[index], context),
                separatorBuilder: (BuildContext context, int index) =>
                    myDivider(),
              )),
        );
      },
    );
  }

  Widget buildChatItem(UserModel userModel, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatsDetailsScreen(userModel: userModel));
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          elevation: 0,
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: CachedNetworkImageProvider(userModel.image!),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${userModel.name}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(height: 1.4)),
                ],
              )),
            ],
          ),
        ),
      );
}
