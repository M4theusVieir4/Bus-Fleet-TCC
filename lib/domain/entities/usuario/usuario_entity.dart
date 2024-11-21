import 'package:busbr/domain/entities/preferencia/preferencia_entity.dart';

class UsuarioEntity {
  int? id;
  String? nome;
  String? login;
  PreferenciaEntity? preferencia;

  UsuarioEntity({
    this.id,
    this.nome,
    this.login,
  });

  UsuarioEntity.fromJson(Map<String, dynamic> json) {
    id = json['idUsuario'];
    nome = json['nomeCompleto'];
    login = json['email'];
    preferencia = json['preferencia'] != null
        ? PreferenciaEntity.fromJson(json['preferencia'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = id;
    data['nomeCompleto'] = nome;
    data['email'] = login;

    return data;
  }
}
