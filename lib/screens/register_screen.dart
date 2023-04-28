import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF181A1F),
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adicione seus campos de nome, e-mail e senha aqui
            const TextField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Palavra-Passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implemente a lógica de cadastro aqui
              },
              child: const Text('Criar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
