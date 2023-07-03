abstract class LogInStates{}
class LogInInitialState extends LogInStates{}
class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  final String uId;
  LogInSuccessState(this.uId);
}
class LogInErrorState extends LogInStates{
  final String error;
  LogInErrorState(this.error);
}


class LogInChangePasswordVisibilityState extends LogInStates{}