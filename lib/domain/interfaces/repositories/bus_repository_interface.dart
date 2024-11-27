import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/infra/config/network/response/result.dart';

abstract class IBusRepository {
  AsyncResult<List<PontoEntity>> search({
    required String enderecoOrigem,
    required String enderecoDestino,
  });

  AsyncResult<Onibus> searchOnibus({
    required int idOnibus,
  });
}
