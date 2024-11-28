import 'package:busbr/domain/entities/comunicacao/equipamento.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/routes/ponto_entity.dart';
import 'package:busbr/domain/interfaces/repositories/bus_repository_interface.dart';
import 'package:busbr/domain/interfaces/repositories/comunication_repository_interface.dart';
import 'package:busbr/domain/interfaces/services/bus_service_interface.dart';
import 'package:busbr/domain/interfaces/services/comunication_service_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';

class ComunicationService implements IComunicationService {
  final IComunicationRepository _comunicationRepository;

  ComunicationService({
    required IComunicationRepository comunicationRepository,
  }) : _comunicationRepository = comunicationRepository;

  @override
  AsyncResult<Equipamento> searchComunication({required int idEquipamento}) {
    var equipamento = _comunicationRepository.searchComunication(
      idEquipamento: idEquipamento,
    );

    return equipamento;
  }
}
