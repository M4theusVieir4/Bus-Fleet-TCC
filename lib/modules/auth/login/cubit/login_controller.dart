import 'package:busbr/domain/interfaces/auth_service_interface.dart';
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

    var loginResult = await _authService.registerUser(
      email: email,
      password: password,
    );

    loginResult.result((data) async {
      emit(LoginSucccessState());
    }, (error) => {emit(LoginErrorState(error.message))});
  }
}