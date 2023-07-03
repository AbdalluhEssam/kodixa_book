// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/chats/cubit/states.dart';


class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  static ChatsCubit get(context) => BlocProvider.of(context);



}
