// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/edit_profile/cubit/states.dart';


class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);



}
