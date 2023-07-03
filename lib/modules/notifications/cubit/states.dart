abstract class NotificationsStates{}
class NotificationsInitialState extends NotificationsStates{}
class NotificationsLoadingState extends NotificationsStates{}
class NotificationsSuccessState extends NotificationsStates{}
class NotificationsErrorState extends NotificationsStates{
  final String error;
  NotificationsErrorState(this.error);
}


class NotificationsChangePasswordVisibilityState extends NotificationsStates{}