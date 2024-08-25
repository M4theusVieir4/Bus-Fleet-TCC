abstract class IAuthService {
  Future<String?> registerUser({
    required String user,
    required String email,
    required String password,
  });

  Future<String?> loginUsers({
    required String email,
    required String password,
  });
}
