// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/modules/notifications/cubit/states.dart';


class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitialState());

  static NotificationsCubit get(context) => BlocProvider.of(context);



}
