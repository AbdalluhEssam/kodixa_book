import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/user_model.dart';
import 'package:kodixa_book/shared/components/components.dart';

class ChatsDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  const ChatsDetailsScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      CachedNetworkImageProvider("${userModel.image}"),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(userModel.name!)
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(20),
                          bottomStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        )),
                    child: Text("Hello"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel userModel, context) => InkWell(
        onTap: () {},
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
