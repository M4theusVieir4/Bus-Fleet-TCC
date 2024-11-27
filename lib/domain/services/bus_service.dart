import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/repositories/bus_repository_interface.dart';
import 'package:busbr/domain/interfaces/services/bus_service_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';

class BusService implements IBusService {
  final IBusRepository _busRepository;

  BusService({
    required IBusRepository busRepository,
  }) : _busRepository = busRepository;

  @override
  AsyncResult<List<PontoEntity>> search({
    required String enderecoOrigem,
    required String enderecoDestino,
  }) {
    var pontos = _busRepository.search(
      enderecoOrigem: enderecoOrigem,
      enderecoDestino: enderecoDestino,
    );
    return pontos;
  }

  @override
  AsyncResult<Onibus> searchBus({required int idOnibus}) {
    var onibus = _busRepository.searchOnibus(idOnibus: idOnibus);
    return onibus;
  }
}
