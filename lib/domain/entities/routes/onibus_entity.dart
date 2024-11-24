class OnibusEntity {
  int? idOnibus;
  int? idEquipamento;
  String? modelo;
  String? placa;
  int? anoFabricacao;
  double? taxaOnibus;
  double? latitude;
  double? longitude;

  OnibusEntity({
    this.idOnibus,
    this.idEquipamento,
    this.modelo,
    this.placa,
    this.anoFabricacao,
    this.taxaOnibus,
    this.latitude,
    this.longitude,
  });

  OnibusEntity.fromJson(Map<String, dynamic> json) {
    idOnibus = json['idOnibus'];
    idEquipamento = json['idEquipamento'];
    modelo = json['modelo'];
    placa = json['placa'];
    anoFabricacao = json['anoFabricacao'];
    taxaOnibus = (json['taxaOnibus'] as num?)?.toDouble();
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
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
    };
  }
}
