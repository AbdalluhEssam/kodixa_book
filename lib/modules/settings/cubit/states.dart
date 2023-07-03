abstract class SettingsStates{}
class SettingsInitialState extends SettingsStates{}
class SettingsLoadingState extends SettingsStates{}
class SettingsSuccessState extends SettingsStates{}
class SettingsErrorState extends SettingsStates{
  final String error;
  SettingsErrorState(this.error);
}


class SettingsChangePasswordVisibilityState extends SettingsStates{}