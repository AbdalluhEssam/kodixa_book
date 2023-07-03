abstract class EditProfileStates{}
class EditProfileInitialState extends EditProfileStates{}
class EditProfileLoadingState extends EditProfileStates{}
class EditProfileSuccessState extends EditProfileStates{}
class EditProfileErrorState extends EditProfileStates{
  final String error;
  EditProfileErrorState(this.error);
}


class EditProfileChangePasswordVisibilityState extends EditProfileStates{}