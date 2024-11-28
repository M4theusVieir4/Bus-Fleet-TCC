import 'package:busbr/domain/entities/comunicacao/catraca.dart';
import 'package:busbr/domain/entities/comunicacao/comunicacao.dart';
import 'package:busbr/domain/entities/onibus/onibus.dart';

class Equipamento {
  final int idEquipamento;
  final String numeroSerie;
  final String modelo;
  final double latitude;
  final double longitude;
  final Catraca catraca;
  final Onibus onibus;
  final List<Comunicacao> comunicacaos;

  Equipamento({
    required this.idEquipamento,
    required this.numeroSerie,
    required this.modelo,
    required this.latitude,
    required this.longitude,
    required this.catraca,
    required this.onibus,
    required this.comunicacaos,
  });

  factory Equipamento.fromJson(Map<String, dynamic> json) {
    var comunicacoesList = json['comunicacaos'] as List;
    List<Comunicacao> comunicacoes = comunicacoesList
        .map((comunicacao) => Comunicacao.fromJson(comunicacao))
        .toList();

    return Equipamento(
      idEquipamento: json['idEquipamento'],
      numeroSerie: json['numeroSerie'],
      modelo: json['modelo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      catraca: Catraca.fromJson(json['catraca']),
      onibus: Onibus.fromJson(json['onibus']),
      comunicacaos: comunicacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idEquipamento': idEquipamento,
      'numeroSerie': numeroSerie,
      'modelo': modelo,
      'latitude': latitude,
      'longitude': longitude,
      'catraca': catraca.toJson(),
      'onibus': onibus.toJson(),
      'comunicacaos':
          comunicacaos.map((comunicacao) => comunicacao.toJson()).toList(),
    };
  }
}
