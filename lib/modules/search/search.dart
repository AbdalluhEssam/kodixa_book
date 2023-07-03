import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                    child: Image.asset("assets/images/DSC_0034.jpg")
                ),
              ));
        },
      ),
    );
  }
}
