import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/interfaces/services/bus_service_interface.dart';
import 'package:busbr/domain/interfaces/services/comunication_service_interface.dart';
import 'package:busbr/modules/bus_tracker/route_bus/cubit/route_bus_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteBusController extends Cubit<RouteBusState> {
  //final String _notificationService;
  final IComunicationService _comunicationService;

  RouteBusController(
    //this._notificationService,
    this._comunicationService,
  ) : super(RouteBusInitialState());

  Future<void> initialize() async {
    emit(RouteBusLoadingState());
    emit(RouteBusInitialState());
  }

  Future<void> getBusLocation({required int idEquipamento}) async {
    emit(RouteBusLoadingState());

    var comunicationResult = await _comunicationService.searchComunication(
      idEquipamento: idEquipamento,
    );
    comunicationResult.result((data) async {
      Equipamento equipamento = data;
      emit(RouteBusSuccessState(equipamento));
    }, (error) => emit(RouteBusErrorState(error.message)));
  }
}
