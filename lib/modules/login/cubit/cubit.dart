// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/login/cubit/states.dart';
import 'package:kodixa_book/shared/components/components.dart';


class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isPassShow = true;

  void changePasswordVisibility() {
    isPassShow = !isPassShow;
    emit(LogInChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LogInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LogInLoadingState());
      // CacheHelper.saveData(key: 'uId', value: value.user!.uid.toString());
      showToast(text: "Login Success", state: ToastStates.SUCCESS);
      emit(LogInSuccessState(value.user!.uid));
    }).catchError((onError) {
      print("Error is $onError");
      emit(LogInErrorState(onError.toString()));
    });
  }
}
