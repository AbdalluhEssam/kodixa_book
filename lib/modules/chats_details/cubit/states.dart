abstract class ChatsStates{}
class ChatsInitialState extends ChatsStates{}
class ChatsLoadingState extends ChatsStates{}
class ChatsSuccessState extends ChatsStates{}
class ChatsErrorState extends ChatsStates{
  final String error;
  ChatsErrorState(this.error);
}


class ChatsChangePasswordVisibilityState extends ChatsStates{}