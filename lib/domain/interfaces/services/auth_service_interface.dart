import 'package:busbr/data/models/login_response_model.dart';
import 'package:busbr/infra/config/network/response/result.dart';

abstract class IAuthService {
  AsyncResult<String?> registerUser({
    required String user,
    required String email,
    required String password,
  });

  AsyncResult<LoginResponseModel> login({
    required String email,
    required String password,
  });
}
