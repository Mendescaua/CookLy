import 'package:cookly/pages/main_screen.dart';
import 'package:cookly/pages/splash_screen.dart';
import 'package:cookly/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  @override
Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: AuthService().authStateChanges,
    builder: (context, snapshot) {
      print("AuthGate - Usuário logado: ${snapshot.data}"); // Debug

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final user = snapshot.data;
      return user != null ? const MainScreen() : const SplashScreen();
    },
  );
}

}
