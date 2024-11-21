import 'package:busbr/domain/entities/usuario/usuario_entity.dart';

sealed class LoginState {
  late final UsuarioEntity? user;

  LoginState(this.user);
}

class LoginIniticialState extends LoginState {
  LoginIniticialState() : super(null);
}

class LoginInitializedState extends LoginState {
  LoginInitializedState() : super(null);
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super(null);
}

class LoginSucccessState extends LoginState {
  LoginSucccessState(super.user);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message) : super(null);
}
