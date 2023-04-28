import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final String image = 'assets/images/logo_b.png';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF181A1F),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.primaryDarkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.srcATop,
              ),
            ),
          ),
        ),
            
            // Adicione seus campos de e-mail e senha aqui
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implemente a lógica de login aqui
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
