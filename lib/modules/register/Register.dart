import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/register/cubit/cubit.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../layout/social_app.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) async{
          if(state is CreateUserSuccessState){
           await CacheHelper.saveData(key: 'uId', value: state.uId.toString()).then((value) {
             if(CacheHelper.getData(key: 'uId') != null){
               navigateAndFinish(context, const SocialAppLayout());
             }
            }).catchError((onError){
              print(onError);
            });

          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                          const Text("Register",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Register Now To Communicate With Friends",
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
                                return "User Name Not br Empty";
                              }
                              return null;
                            },
                            controller: cubit.userName,
                            keyboardType: TextInputType.text,
                            labelText: "User Name",
                            icon: Icons.person,
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
                            height: 20,
                          ),
                          defaultTextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Phone  Not br Empty";
                              }
                              return null;
                            },
                            controller: cubit.phone,
                            keyboardType: TextInputType.phone,
                            labelText: "Phone",
                            icon: Icons.phone,
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
                            height: 40,
                          ),
                          defaultButton(
                              text: "Register",
                              onPressed: () async {
                                  cubit.userRegister(
                                      name: cubit.userName.text,
                                      email: cubit.email.text,
                                      password: cubit.password.text,
                                      phone: cubit.phone.text);

                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("have an account?"),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, const LohInScreen());
                                },
                                child: const Text("Login Now"),
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
