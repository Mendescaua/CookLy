import 'package:cookly/services/firebase_auth.dart';
import 'package:cookly/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //get instance of AuthService
  final authService = AuthService();

  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //função para logar
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    String? errorMessage =
        await authService.signIn(email: email, password: password);

    if (errorMessage != null) {
      // Exibir erro na tela
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color.fromARGB(255, 255, 69, 56),
        ),
      );
    } else {
      Navigator.pop(context);
      print("Login realizado com sucesso!");
    }
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              const Column(
                children: [
                  Text(
                    "Hello Again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 37,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Welcome Back you've\nbeen missed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      color: textColor,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              myTextFieldEmail("Email", controller: _emailController),
              myTextField("Password", Colors.black26,
                  controller: _passwordController),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "Forgot password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(size.width * 1, 0),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container myTextField(String hint, Color color,
      {required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        obscureText: _obscureText,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          fillColor: const Color(0x5088B04B),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(174, 22, 22, 26),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: color,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }

  Container myTextFieldEmail(String hint,
      {required TextEditingController controller}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          fillColor: const Color(0x5088B04B),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(174, 22, 22, 26),
          ),
        ),
      ),
    );
  }
}
