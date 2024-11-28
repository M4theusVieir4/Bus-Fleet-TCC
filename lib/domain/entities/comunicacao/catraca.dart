class Catraca {
  final int idCatraca;
  final int idEquipamento;
  final String local;
  final int quantidadeEntrada;
  final int quantidadeSaida;

  Catraca({
    required this.idCatraca,
    required this.idEquipamento,
    required this.local,
    required this.quantidadeEntrada,
    required this.quantidadeSaida,
  });

  factory Catraca.fromJson(Map<String, dynamic> json) {
    return Catraca(
      idCatraca: json['idCatraca'],
      idEquipamento: json['idEquipamento'],
      local: json['local'],
      quantidadeEntrada: json['quantidadeEntrada'],
      quantidadeSaida: json['quantidadeSaida'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCatraca': idCatraca,
      'idEquipamento': idEquipamento,
      'local': local,
      'quantidadeEntrada': quantidadeEntrada,
      'quantidadeSaida': quantidadeSaida,
    };
  }
}
