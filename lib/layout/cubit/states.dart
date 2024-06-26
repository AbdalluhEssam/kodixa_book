abstract class SocialStates{}
class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String error;
  SocialGetAllUserErrorState(this.error);
}

class SocialGetAllUserOnlyLoadingState extends SocialStates{}
class SocialGetAllUserOnlySuccessState extends SocialStates{}
class SocialGetAllUserOnlyErrorState extends SocialStates{
  final String error;
  SocialGetAllUserOnlyErrorState(this.error);
}

class SocialGetUserPostLoadingState extends SocialStates{}
class SocialGetUserPostSuccessState extends SocialStates{}
class SocialGetUserPostErrorState extends SocialStates{
  final String error;
  SocialGetUserPostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}

class SocialProfileImageSuccessState extends SocialStates{}
class SocialProfileImageErrorState extends SocialStates{}

class SocialPostImageSuccessState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadProfileCoverSuccessState extends SocialStates{}
class SocialUploadProfileCoverErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}

///////////////////// POST /////////////////
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}

//////////// GET POST ////////////////
class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{
  final String error;
  SocialGetPostErrorState(this.error);
}

class SocialGetPostOnlyLoadingState extends SocialStates{}

class SocialGetPostOnlySuccessState extends SocialStates{}
class SocialGetPostOnlyErrorState extends SocialStates{
  final String error;
  SocialGetPostOnlyErrorState(this.error);
}

//////////// Like POST ////////////////
class SocialLikePostLoadingState extends SocialStates{}

class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}
//////////// Like POST ////////////////
class SocialLikePostOnlyLoadingState extends SocialStates{}

class SocialLikePostOnlySuccessState extends SocialStates{}
class SocialLikePostOnlyErrorState extends SocialStates{
  final String error;
  SocialLikePostOnlyErrorState(this.error);
}
class SocialUnLikePostSuccessState extends SocialStates{}

class SocialUnLikePostErrorState extends SocialStates{
  final String error;
  SocialUnLikePostErrorState(this.error);
}

class SocialPlusLikePostSuccessState extends SocialStates{}
class SocialMinLikePostSuccessState extends SocialStates{}
class SocialAddLikePostSuccessState extends SocialStates{}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final String error;
  SocialSendMessageErrorState(this.error);
}


class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
  final String error;
  SocialGetMessageErrorState(this.error);
}


class SocialSendCommentSuccessState extends SocialStates{}
class SocialSendCommentErrorState extends SocialStates{
  final String error;
  SocialSendCommentErrorState(this.error);
}

class SocialGetCommentSuccessState extends SocialStates{}
class SocialGetCommentErrorState extends SocialStates{
  final String error;
  SocialGetCommentErrorState(this.error);
}

class SocialGetCommentOnlySuccessState extends SocialStates{}
class SocialGetCommentOnlyErrorState extends SocialStates{
  final String error;
  SocialGetCommentOnlyErrorState(this.error);
}
