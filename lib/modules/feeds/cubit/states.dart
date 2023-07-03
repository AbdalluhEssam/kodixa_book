abstract class FeedsStates{}
class FeedsInitialState extends FeedsStates{}
class FeedsLoadingState extends FeedsStates{}
class FeedsSuccessState extends FeedsStates{}
class FeedsErrorState extends FeedsStates{
  final String error;
  FeedsErrorState(this.error);
}


class FeedsChangePasswordVisibilityState extends FeedsStates{}