import 'package:busbr/data/models/login_response_model.dart';
import 'package:busbr/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:busbr/domain/interfaces/services/auth_service_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements IAuthService {
  final IAuthRepository _authRepository;

  AuthService({
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  AsyncResult<String?> registerUser(
      {required String user, required String email, required String password}) {
    return _authRepository.registerUser(
        userName: user, email: email, password: password);
  }

  @override
  AsyncResult<LoginResponseModel> login(
      {required String email, required String password}) {
    return _authRepository.login(email: email, password: password);
  }
}
