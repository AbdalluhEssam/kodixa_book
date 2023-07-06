import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodixa_book/shared/styles/colors.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: Container(
              padding: const EdgeInsets.all(5),
              child: cubit.users.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
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
        child: Card(
          color: defaultColor.shade50,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          CachedNetworkImageProvider(userModel.image!),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 5),
                            child: Text("${userModel.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: 1.4)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(IconBroken.Add_User),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Follow"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat('jm', 'en_US').format(DateTime.now()).toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
