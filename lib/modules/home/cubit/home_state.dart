sealed class HomeState {}

class HomeInitialState implements HomeState {}

class LoadingHomeState implements HomeState {}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}

class HomeSuccessState extends HomeState {
  final bool hasNotifications;
  HomeSuccessState(this.hasNotifications);
}
