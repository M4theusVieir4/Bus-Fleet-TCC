import 'package:busbr/domain/entities/routes/onibus_entity.dart';
import 'package:busbr/domain/entities/routes/onibus_rota_entity.dart';
import 'package:busbr/domain/entities/routes/rota_entity.dart';

class PontoEntity {
  int? idPonto;
  String? ruaAvenida;
  String? bairro;
  String? estado;
  List<RotaEntity>? rotas;
  List<OnibusEntity>? onibus;
  List<OnibusRotaEntity>? onibusRota;

  PontoEntity(
      {this.idPonto,
      this.ruaAvenida,
      this.bairro,
      this.estado,
      this.rotas,
      this.onibus,
      this.onibusRota});

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
    onibusRota = (json['onibusRotas'] as List<dynamic>?)
        ?.map((e) => OnibusRotaEntity.fromJson(e))
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
      'onibusRotas': onibusRota?.map((e) => e.toJson()).toList(),
    };
  }
}
