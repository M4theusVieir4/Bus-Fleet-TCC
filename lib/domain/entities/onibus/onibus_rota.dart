import 'package:busbr/domain/entities/onibus/rota.dart';

class OnibusRota {
  final int idOnibus;
  final int idRotas;
  final Rota rota;

  OnibusRota({
    required this.idOnibus,
    required this.idRotas,
    required this.rota,
  });

  factory OnibusRota.fromJson(Map<String, dynamic> json) {
    return OnibusRota(
      idOnibus: json['idOnibus'],
      idRotas: json['idRotas'],
      rota: Rota.fromJson(json['rota']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOnibus': idOnibus,
      'idRotas': idRotas,
      'rota': rota.toJson(),
    };
  }
}
