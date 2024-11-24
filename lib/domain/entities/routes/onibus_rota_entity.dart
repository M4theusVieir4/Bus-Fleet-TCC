class OnibusRotaEntity {
  final int idOnibus;
  final int idRotas;

  OnibusRotaEntity({
    required this.idOnibus,
    required this.idRotas,
  });

  factory OnibusRotaEntity.fromJson(Map<String, dynamic> map) {
    return OnibusRotaEntity(
      idOnibus: map['idOnibus'],
      idRotas: map['idRotas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOnibus': idOnibus,
      'idRotas': idRotas,
    };
  }
}
