import 'package:busbr/domain/entities/routes/ponto_entity.dart';

sealed class HomeState {
  late final List<PontoEntity>? ponto;

  HomeState(this.ponto);
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(null);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(null);
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message) : super(null);
}

class HomeSuccessState extends HomeState {
  //final bool hasNotifications;

  HomeSuccessState(super.ponto);
}
