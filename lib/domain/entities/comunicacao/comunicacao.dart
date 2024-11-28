class Comunicacao {
  final int idDados;
  final int idEquipamento;
  final String data;
  final double latitude;
  final double longitude;

  Comunicacao({
    required this.idDados,
    required this.idEquipamento,
    required this.data,
    required this.latitude,
    required this.longitude,
  });

  factory Comunicacao.fromJson(Map<String, dynamic> json) {
    return Comunicacao(
      idDados: json['idDados'],
      idEquipamento: json['idEquipamento'],
      data: json['data'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDados': idDados,
      'idEquipamento': idEquipamento,
      'data': data,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
