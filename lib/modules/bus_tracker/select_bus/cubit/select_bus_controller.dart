import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/services/bus_service_interface.dart';
import 'package:busbr/modules/bus_tracker/select_bus/cubit/select_bus_state.dart';
import 'package:busbr/modules/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBusController extends Cubit<SelectBusState> {
  //final String _notificationService;
  final IBusService _busService;

  SelectBusController(
    //this._notificationService,
    this._busService,
  ) : super(SelectBusInitialState());

  Future<void> initialize() async {
    emit(SelectBusLoadingState());
    emit(SelectBusInitialState());
  }

  Future<void> buscarOnibus({required int idOnibus}) async {
    emit(SelectBusLoadingState());

    var onibusResult = await _busService.searchBus(idOnibus: idOnibus);
    onibusResult.result((data) async {
      Onibus onibus = data;
      emit(SelectBusSuccessState(onibus));
    }, (error) => emit(SelectBusErrorState(error.message)));
  }
}
