import 'package:busbr/infra/config/network/response/result.dart';

abstract class IAuthService {
  Future<String> registerUser({
    required String user,
    required String email,
    required String password,
  });
}
