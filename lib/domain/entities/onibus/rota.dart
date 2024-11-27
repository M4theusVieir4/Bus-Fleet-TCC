import 'package:busbr/domain/entities/onibus/rotas_ponto.dart';

class Rota {
  final int idRotas;
  final String nomeRota;
  final List<RotasPonto> rotasPontos;

  Rota({
    required this.idRotas,
    required this.nomeRota,
    required this.rotasPontos,
  });

  factory Rota.fromJson(Map<String, dynamic> json) {
    var list = json['rotasPontos'] as List;
    List<RotasPonto> rotasPontosList =
        list.map((i) => RotasPonto.fromJson(i)).toList();

    return Rota(
      idRotas: json['idRotas'],
      nomeRota: json['nome_Rota'],
      rotasPontos: rotasPontosList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idRotas': idRotas,
      'nome_Rota': nomeRota,
      'rotasPontos': rotasPontos.map((ponto) => ponto.toJson()).toList(),
    };
  }
}
