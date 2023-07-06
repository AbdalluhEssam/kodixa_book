import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kodixa_book/shared/components/constants.dart';
import 'package:kodixa_book/shared/network/local/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/social_app.dart';
import '../register/Register.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LohInScreen extends StatelessWidget {
  const LohInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
        listener: (context, state)async {
          if (state is LogInErrorState) {
            showToast(text: "Error is ${state.error}", state: ToastStates.ERROR);
          }

          if (state is LogInSuccessState) {
            await  CacheHelper.saveData(key: 'uId', value: state.uId.toString()).then((value) {
              navigateAndFinish(context, const SocialAppLayout());
            }).catchError((onError){
              print("Error LogIn is $onError");
            });
          }
        },
        builder: (context, state) {
          var cubit = LogInCubit.get(context);
          return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.formState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Login",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Login Now To Communicate With Friends",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Email Address Not br Empty";
                              }
                              return null;
                            },
                            controller: cubit.email,
                            keyboardType: TextInputType.emailAddress,
                            labelText: "Email",
                            icon: Icons.email,
                            onFieldSubmitted: (val) {
                              if (kDebugMode) {
                                print(val);
                              }
                            },
                            onChanged: (val) {
                              if (kDebugMode) {
                                print(val);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password Not br Empty";
                                }
                                return null;
                              },
                              controller: cubit.password,
                              keyboardType: TextInputType.visiblePassword,
                              labelText: "Password",
                              icon: Icons.lock,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              isPassShow: cubit.isPassShow,
                              suffixIcon: cubit.isPassShow == true
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash_fill),
                          const SizedBox(
                            height: 40,
                          ),
                          defaultButton(
                              text: "LOGIN",
                              onPressed: () {
                                if (cubit.formState.currentState!.validate()) {
                                  if (kDebugMode) {
                                    print(cubit.email.text);
                                    print(cubit.password.text);
                                  }
                                  cubit.userLogin(
                                      email: cubit.email.text,
                                      password: cubit.password.text);
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                child: const Text("Register Now"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
