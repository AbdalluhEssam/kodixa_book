// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/users/cubit/states.dart';


class UsersCubit extends Cubit<UsersStates> {
  UsersCubit() : super(UsersInitialState());

  static UsersCubit get(context) => BlocProvider.of(context);



}
