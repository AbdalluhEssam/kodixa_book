import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kodixa_book/modules/login/login.dart';
import 'package:kodixa_book/shared/bloc_observer.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/components/constants.dart';
import 'package:kodixa_book/shared/cubit/cubit.dart';
import 'package:kodixa_book/shared/cubit/states.dart';
import 'package:kodixa_book/shared/network/local/cache_helper.dart';
import 'package:kodixa_book/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/social_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print(token);
  }

  FirebaseMessaging.onMessage.listen((event) {
    showToast(text: 'onMessage', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text: 'onMessageOpenedApp', state: ToastStates.SUCCESS);
  });

  await CacheHelper.init();
  Widget widget;
  if (await CacheHelper.getData(key: 'uId') != null) {
    uId = await CacheHelper.getData(key: 'uId');
  } else {
    uId = '';
  }

  if (uId.isNotEmpty) {
    widget = const SocialAppLayout();
  } else {
    widget = const LohInScreen();
  }

  runApp(MyApp(isDark: false, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) =>
              AppCubit()..changeDarkModeSheet(formShared: isDark!),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            themeMode: ThemeMode.light,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
