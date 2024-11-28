import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';

sealed class RouteBusState {
  late final Equipamento? equipamento;

  RouteBusState(this.equipamento);
}

class RouteBusInitialState extends RouteBusState {
  RouteBusInitialState() : super(null);
}

class RouteBusLoadingState extends RouteBusState {
  RouteBusLoadingState() : super(null);
}

class RouteBusErrorState extends RouteBusState {
  final String message;
  RouteBusErrorState(this.message) : super(null);
}

class RouteBusSuccessState extends RouteBusState {
  //final bool hasNotifications;

  RouteBusSuccessState(super.equipamento);
}
