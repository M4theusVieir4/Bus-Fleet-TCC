import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/repositories/bus_repository_interface.dart';
import 'package:busbr/infra/config/network/endpoints/endpoints.dart';
import 'package:busbr/infra/config/network/response/client/http_client_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:busbr/infra/core/extensions/future/future_extension.dart';

class BusRepository extends IBusRepository {
  final IHttpClient _httpClient;

  BusRepository({
    required IHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  AsyncResult<List<PontoEntity>> search({
    required String enderecoOrigem,
    required String enderecoDestino,
  }) {
    final List<Map<String, dynamic>> data = [
      {
        "ruaAvenida": enderecoOrigem,
      },
      {
        "ruaAvenida": enderecoDestino,
      }
    ];

    return _httpClient
        .post(Endpoints.searchPonto, data: data)
        .resultList((json) {
      return json.map((e) => PontoEntity.fromJson(e)).toList();
    });
  }
}
