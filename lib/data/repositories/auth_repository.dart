import 'package:busbr/data/models/login_response_model.dart';
import 'package:busbr/domain/interfaces/repositories/auth_repository_interface.dart';
import 'package:busbr/infra/config/network/endpoints/endpoints.dart';
import 'package:busbr/infra/config/network/response/client/http_client_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:busbr/infra/core/extensions/future/future_extension.dart';

class AuthRepository implements IAuthRepository {
  final IHttpClient _httpClient;

  AuthRepository({
    required IHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  AsyncResult<String?> registerUser(
      {required String userName,
      required String email,
      required String password}) {
    return _httpClient.post(Endpoints.registerUser, data: {
      'nomeCompleto': userName,
      'numeroCelular': 848948484,
      'email': email,
      'password': password,
    }).result((json) => json['message']);
  }

  @override
  AsyncResult<LoginResponseModel> login({
    required String email,
    required String password,
  }) {
    return _httpClient.post(Endpoints.loginUser, data: {
      'email': email,
      'password': password
    }).result((json) => LoginResponseModel.fromJson(json));
  }
}
