import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';

sealed class SelectBusState {
  late final Onibus? onibus;

  SelectBusState(this.onibus);
}

class SelectBusInitialState extends SelectBusState {
  SelectBusInitialState() : super(null);
}

class SelectBusLoadingState extends SelectBusState {
  SelectBusLoadingState() : super(null);
}

class SelectBusErrorState extends SelectBusState {
  final String message;
  SelectBusErrorState(this.message) : super(null);
}

class SelectBusSuccessState extends SelectBusState {
  //final bool hasNotifications;

  SelectBusSuccessState(super.onibus);
}
