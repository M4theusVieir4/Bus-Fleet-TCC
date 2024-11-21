import 'package:busbr/domain/entities/preferencia/preferencia_entity.dart';
import 'package:busbr/domain/entities/usuario/usuario_entity.dart';

class LoginResponseModel {
  UsuarioEntity? usuario;
  String? token;
  int? expire;
  String? tokenAtualizacao;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    usuario =
        json['user'] != null ? UsuarioEntity.fromJson(json['user']) : null;

    token = json['token'];
    expire = json['expire'];
    tokenAtualizacao = json['tokenAtualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) {
      data['user'] = usuario!.toJson();
    }
    data['token'] = token;
    data['expire'] = expire;
    data['tokenAtualizacao'] = tokenAtualizacao;
    return data;
  }
}
