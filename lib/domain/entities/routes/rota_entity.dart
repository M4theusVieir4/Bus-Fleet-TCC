class RotaEntity {
  int? idRotas;
  String? nomeRota;

  RotaEntity({
    this.idRotas,
    this.nomeRota,
  });

  RotaEntity.fromJson(Map<String, dynamic> json) {
    idRotas = json['idRotas'];
    nomeRota = json['nome_Rota'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idRotas': idRotas,
      'nome_Rota': nomeRota,
    };
  }
}
