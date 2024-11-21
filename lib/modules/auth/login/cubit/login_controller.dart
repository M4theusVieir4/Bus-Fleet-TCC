import 'package:busbr/domain/entities/usuario/usuario_entity.dart';
import 'package:busbr/domain/interfaces/services/auth_service_interface.dart';
import 'package:busbr/modules/auth/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginController extends Cubit<LoginState> {
  final IAuthService _authService;
  LoginController(this._authService) : super(LoginInitializedState());

  Future<void> initialize() async {
    emit(LoginLoadingState());

    emit(LoginInitializedState());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    var loginResult = await _authService.login(
      email: email,
      password: password,
    );
    loginResult.result((data) async {
      UsuarioEntity user = data.usuario!;
      emit(LoginSucccessState(user));
    }, (error) => emit(LoginErrorState(error.message)));
  }
}
