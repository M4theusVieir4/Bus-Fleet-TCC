import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/services/bus_service_interface.dart';
import 'package:busbr/modules/auth/login/cubit/login_state.dart';
import 'package:busbr/modules/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController extends Cubit<HomeState> {
  //final String _notificationService;
  final IBusService _busService;

  HomeController(
    //this._notificationService,
    this._busService,
  ) : super(HomeInitialState());

  Future<void> initialize() async {
    emit(HomeLoadingState());
    emit(HomeInitialState());
  }

  Future<void> buscarRota({
    required String enderecoOrigem,
    required String enderecoDestino,
  }) async {
    emit(HomeLoadingState());

    var onibusResult = await _busService.search(
      enderecoOrigem: enderecoOrigem,
      enderecoDestino: enderecoDestino,
    );
    onibusResult.result((data) async {
      List<PontoEntity> ponto = data;
      emit(HomeSuccessState(ponto));
    }, (error) => emit(HomeErrorState(error.message)));
  }
}
