import 'package:busbr/domain/entities/onibus/onibus_rota.dart';

class Onibus {
  final int idOnibus;
  final int idEquipamento;
  final String modelo;
  final String placa;
  final int anoFabricacao;
  final double taxaOnibus;
  final double latitude;
  final double longitude;
  final List<OnibusRota> onibusRotas;

  Onibus({
    required this.idOnibus,
    required this.idEquipamento,
    required this.modelo,
    required this.placa,
    required this.anoFabricacao,
    required this.taxaOnibus,
    required this.latitude,
    required this.longitude,
    required this.onibusRotas,
  });

  factory Onibus.fromJson(Map<String, dynamic> json) {
    var list = json['onibusRotas'] as List;
    List<OnibusRota> onibusRotasList =
        list.map((i) => OnibusRota.fromJson(i)).toList();

    return Onibus(
      idOnibus: json['idOnibus'],
      idEquipamento: json['idEquipamento'],
      modelo: json['modelo'],
      placa: json['placa'],
      anoFabricacao: json['anoFabricacao'],
      taxaOnibus: json['taxaOnibus'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      onibusRotas: onibusRotasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOnibus': idOnibus,
      'idEquipamento': idEquipamento,
      'modelo': modelo,
      'placa': placa,
      'anoFabricacao': anoFabricacao,
      'taxaOnibus': taxaOnibus,
      'latitude': latitude,
      'longitude': longitude,
      'onibusRotas': onibusRotas.map((rota) => rota.toJson()).toList(),
    };
  }
}
