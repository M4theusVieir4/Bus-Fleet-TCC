import 'package:busbr/domain/interfaces/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements IAuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'E-mail já existe';
      }
    }
  }
}
