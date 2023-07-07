import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/models/massage_model.dart';
import 'package:kodixa_book/models/user_model.dart';
import 'package:kodixa_book/shared/styles/colors.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

class ChatsDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  const ChatsDetailsScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId!);
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userModel.bio!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1),
                          textAlign: TextAlign.end,
                        )
                      ],
                    )
                  ],
                ),
                elevation: 5,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(IconBroken.Call)),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    cubit.messages.isNotEmpty
                        ? Expanded(
                            child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message = cubit.messages[index];
                                  if (cubit.userModel!.uId! ==
                                      message.senderId) {
                                    return buildMyMessage(message);
                                  }
                                  return buildMessage(message);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: cubit.messages.length),
                          ))
                        : Expanded(
                            child: Center(
                                child: Text(
                              "New Chat With ${userModel.name}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                          ),
                    Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: cubit.formKey,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: cubit.textMassageController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'not message';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: 'type your message here...',
                                    border: InputBorder.none),
                              )),
                              Container(
                                  height: 50,
                                  color: defaultColor,
                                  child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: () {
                                      cubit.sendMassage(
                                          receiverId: userModel.uId!,
                                          dateTime: DateTime.now().toString(),
                                          text:
                                              cubit.textMassageController.text);
                                    },
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
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

  Widget buildMessage(MassageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('jm', 'en_US')
                    .format(DateTime.parse(model.dateTime!))
                    .toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(model.text!),
            ],
          ),
        ),
      );

  Widget buildMyMessage(MassageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.4),
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model.text!),
              const SizedBox(
                width: 5,
              ),
              Text(
                DateFormat('jm', 'en_US')
                    .format(DateTime.parse(model.dateTime!))
                    .toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      );
}
