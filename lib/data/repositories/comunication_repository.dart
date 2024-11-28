import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/repositories/bus_repository_interface.dart';
import 'package:busbr/domain/interfaces/repositories/comunication_repository_interface.dart';
import 'package:busbr/infra/config/network/endpoints/endpoints.dart';
import 'package:busbr/infra/config/network/response/client/http_client_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:busbr/infra/core/extensions/future/future_extension.dart';

class ComunicationRepository extends IComunicationRepository {
  final IHttpClient _httpClient;

  ComunicationRepository({
    required IHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  AsyncResult<Onibus> searchOnibus({required int idOnibus}) {
    return _httpClient
        .get(Endpoints.busSearch(idOnibus))
        .result((json) => Onibus.fromJson(json));
  }

  @override
  AsyncResult<Equipamento> searchComunication({required int idEquipamento}) {
    return _httpClient
        .get(Endpoints.comunicationSearch(idEquipamento))
        .result((json) => Equipamento.fromJson(json));
  }
}
