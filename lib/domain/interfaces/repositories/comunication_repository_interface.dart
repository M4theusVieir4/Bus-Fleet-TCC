import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/infra/config/network/response/result.dart';

abstract class IComunicationRepository {
  AsyncResult<Equipamento> searchComunication({
    required int idEquipamento,
  });
}
