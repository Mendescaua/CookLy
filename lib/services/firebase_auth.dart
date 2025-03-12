import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null; // Retorna null se não houver erro
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "Ocorreu um erro inesperado.";
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Preencha todos os campos.';
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "Ocorreu um erro inesperado.";
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Método privado para tratar os erros de autenticação
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';
      case 'email-already-in-use':
        return 'E-mail já cadastrado.';
      case 'user-not-found':
        return 'Nenhum usuário encontrado para esse e-mail.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case "invalid-credential":
        return 'Email inválido ou senha incorreta.';
      case "invalid-email":
        return 'Email inválido.';
      default:
        return 'Ocorreu um erro. Código: ${e.code}';
    }
  }
}
