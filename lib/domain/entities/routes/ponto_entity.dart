import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/rota_entity.dart';

class PontoEntity {
  int? idPonto;
  String? ruaAvenida;
  String? bairro;
  String? estado;
  List<RotaEntity>? rotas;
  List<OnibusEntity>? onibus;

  PontoEntity({
    this.idPonto,
    this.ruaAvenida,
    this.bairro,
    this.estado,
    this.rotas,
    this.onibus,
  });

  PontoEntity.fromJson(Map<String, dynamic> json) {
    idPonto = json['idPonto'];
    ruaAvenida = json['ruaAvenida'];
    bairro = json['bairro'];
    estado = json['estado'];
    rotas = (json['rotas'] as List<dynamic>?)
        ?.map((e) => RotaEntity.fromJson(e))
        .toList();
    onibus = (json['onibus'] as List<dynamic>?)
        ?.map((e) => OnibusEntity.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idPonto': idPonto,
      'ruaAvenida': ruaAvenida,
      'bairro': bairro,
      'estado': estado,
      'rotas': rotas?.map((e) => e.toJson()).toList(),
      'onibus': onibus?.map((e) => e.toJson()).toList(),
    };
  }
}
