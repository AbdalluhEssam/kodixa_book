abstract class UsersStates{}
class UsersInitialState extends UsersStates{}
class UsersLoadingState extends UsersStates{}
class UsersSuccessState extends UsersStates{}
class UsersErrorState extends UsersStates{
  final String error;
  UsersErrorState(this.error);
}


class UsersChangePasswordVisibilityState extends UsersStates{}