import 'package:busbr/domain/interfaces/auth_service_interface.dart';
import 'package:busbr/modules/auth/register/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController extends Cubit<RegisterState> {
  final IAuthService _authService;
  RegisterController(this._authService) : super(RegisterInitializedState());

  Future<void> initialize() async {
    emit(RegisterLoadingState());

    emit(RegisterInitializedState());
  }

  Future<void> register({
    required String user,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    var registerResult = await _authService.registerUser(
      user: user,
      email: email,
      password: password,
    );

    if (registerResult == "Usuário Cadastrado") {
      emit(RegisterSucccessState());
    } else {
      emit(RegisterErrorState(registerResult));
    }
  }
}
