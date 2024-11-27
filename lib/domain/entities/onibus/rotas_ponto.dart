import 'package:busbr/domain/entities/onibus/ponto.dart';

class RotasPonto {
  final int idRota;
  final int idPonto;
  final int ordem;
  final Ponto ponto;

  RotasPonto({
    required this.idRota,
    required this.idPonto,
    required this.ordem,
    required this.ponto,
  });

  factory RotasPonto.fromJson(Map<String, dynamic> json) {
    return RotasPonto(
      idRota: json['idRota'],
      idPonto: json['idPonto'],
      ordem: json['ordem'],
      ponto: Ponto.fromJson(json['ponto']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idRota': idRota,
      'idPonto': idPonto,
      'ordem': ordem,
      'ponto': ponto.toJson(),
    };
  }
}
