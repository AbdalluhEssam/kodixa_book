abstract class NewPostsStates{}
class NewPostsInitialState extends NewPostsStates{}
class NewPostsLoadingState extends NewPostsStates{}
class NewPostsSuccessState extends NewPostsStates{}
class NewPostsErrorState extends NewPostsStates{
  final String error;
  NewPostsErrorState(this.error);
}


class NewPostsChangePasswordVisibilityState extends NewPostsStates{}