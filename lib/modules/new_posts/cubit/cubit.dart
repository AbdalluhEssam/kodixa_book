// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/new_posts/cubit/states.dart';


class NewPostsCubit extends Cubit<NewPostsStates> {
  NewPostsCubit() : super(NewPostsInitialState());

  static NewPostsCubit get(context) => BlocProvider.of(context);



}
