class PreferenciaEntity {
  final int idPreferencia;
  final int idUsuario;
  final bool deficiencia;
  final bool notificacao;

  PreferenciaEntity({
    required this.idPreferencia,
    required this.idUsuario,
    required this.deficiencia,
    required this.notificacao,
  });

  factory PreferenciaEntity.fromJson(Map<String, dynamic> json) {
    return PreferenciaEntity(
      idPreferencia: json['idPreferencia'] as int,
      idUsuario: json['idUsuario'] as int,
      deficiencia: json['deficiencia'] as bool,
      notificacao: json['notificacao'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPreferencia'] = idPreferencia;
    data['idUsuario'] = idUsuario;
    data['deficiencia'] = deficiencia;
    data['notificacao'] = notificacao;

    return data;
  }
}
