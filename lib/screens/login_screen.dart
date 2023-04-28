import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/shared/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String image = 'assets/images/logo_b.png';
  bool _isObscure = true; // variável para controlar se o texto do TextField é visível ou não

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF181A1F),
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.primaryDarkColor,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_b.png'),
            const SizedBox(height: 30),

            const Text(
                'Iniciar Sessão',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 325,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFC4C4C4)),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Color(0xFFC4C4C4)),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 325,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFC4C4C4)),
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Palavra-passe',
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Color(0xFFC4C4C4)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Color(0xFFC4C4C4),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure; // inverte o valor de _isObscure ao pressionar o botão
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Adicione seus campos de e-mail e senha aqui

            const SizedBox(height: 20),
            CustomButton(
                label: 'Entrar',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                }),
            const SizedBox(height: 80),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não tem uma Conta?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5), // espaço entre os dois textos
                  GestureDetector(
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.none,
                        fontSize: 16,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      // função a ser executada quando o texto é tocado
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              )
          ],
        ),
      ]),
    );
  }
}
