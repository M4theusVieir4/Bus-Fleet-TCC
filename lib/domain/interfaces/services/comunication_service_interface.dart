import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/infra/config/network/response/result.dart';

abstract class IComunicationService {
  AsyncResult<Equipamento> searchComunication({
    required int idEquipamento,
  });
}