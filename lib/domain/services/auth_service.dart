import 'package:busbr/domain/interfaces/auth_service_interface.dart';
import 'package:busbr/infra/config/network/response/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements IAuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> registerUser({
    required String user,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(user);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'E-mail já existe';
      }
      if (e.code == "weak-password") {
        return 'A senha deve ter no mínimo 6 caracteres';
      } else {
        return 'Erro ao cadastrar o usuário';
      }
    } catch (e) {
      return 'Erro desconhecido: $e';
    }
  }

  @override
  Future<String?> loginUsers(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
