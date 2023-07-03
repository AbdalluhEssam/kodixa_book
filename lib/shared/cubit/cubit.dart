// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:kodixa_book/shared/cubit/states.dart';
import 'package:kodixa_book/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  Database? database;
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();



  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangBottomNavBarState());
  }


  void changeDarkModeSheet({bool? formShared}) {
    if (formShared != null) {
      isDarkMode = formShared;
      emit(AppChangDarkModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper.putBoolean(key: "isDark", value: isDarkMode).then((value) {
        emit(AppChangDarkModeState());
      });
    }
  }
}
