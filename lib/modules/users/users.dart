import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(),
      child: BlocConsumer<UsersCubit, UsersStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = UsersCubit.get(context);
          return Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child:  Text("Users"),
              ));
        },
      ),
    );
  }
}
