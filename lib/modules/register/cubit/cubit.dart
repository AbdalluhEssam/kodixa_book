// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/models/user_model.dart';
import 'package:kodixa_book/modules/register/cubit/states.dart';
import 'package:kodixa_book/shared/components/components.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isPassShow = true;

  void changePasswordVisibility() {
    isPassShow = !isPassShow;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    if (formState.currentState!.validate()) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      showToast(text: "Register Success", state: ToastStates.SUCCESS);
      emit(RegisterSuccessState());
    }).catchError((onError) {
      print("Error is $onError");
      emit(RegisterErrorState(onError));
    });
    }
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio...',
      image: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Facebook_default_male_avatar.gif',
      cover: 'https://img.freepik.com/free-photo/carefree-woman-dancing-dance-floor-with-close-eyes-smile-enjoying-life-feeling-happy-joyf_1258-143027.jpg?w=1800&t=st=1688292620~exp=1688293220~hmac=1b4362240e2cb18f13ad20059f6232e3834698dee7a84c4c837a9be9aba025c5',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((onError) {
      print("Error is $onError");
      emit(CreateUserErrorState(onError));
    });
  }




}
