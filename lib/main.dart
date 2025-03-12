import 'package:cookly/firebase_options.dart';
import 'package:cookly/pages/favorite_screen.dart';
import 'package:cookly/pages/home_screen.dart';
import 'package:cookly/pages/login_screen.dart';
import 'package:cookly/pages/quikfood_screen.dart';
import 'package:cookly/pages/register_screen.dart';
import 'package:cookly/pages/settings_screen.dart';
import 'package:cookly/pages/splash_screen.dart';
import 'package:cookly/services/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const CookLy());
}

class CookLy extends StatelessWidget {
  const CookLy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookLy',
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/quikfood': (context) => const QuikfoodScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
