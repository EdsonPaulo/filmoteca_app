import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/shared/custom_button.dart';

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
      backgroundColor: AppColors.darkPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_b.png'),
            const SizedBox(height: 30),
            const Text(
              'Criar Conta',
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  // Adicione seus campos de nome, e-mail e senha aqui

                  SizedBox(
                    width: 325,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFC4C4C4)),
                      decoration: InputDecoration(
                        hintText: 'Nome e Sobrenome',
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Color(0xFFC4C4C4)),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                        fillColor: const Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 325,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFC4C4C4)),
                      decoration: InputDecoration(
                        hintText: 'Palavra-passe',
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Color(0xFFC4C4C4)),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                            color: Color(0xFFC4C4C4),
                          ),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 325,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFC4C4C4)),
                      decoration: InputDecoration(
                        hintText: 'Confirmar Palavra-passe',
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Color(0xFFC4C4C4)),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility_outlined,
                            color: Color(0xFFC4C4C4),
                          ),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF2A2D38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                      label: 'Criar Conta',
                      onPressed: () {
                        //Navigator.pushNamed(context, '/login');
                      }),
                  const SizedBox(height: 80),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tem uma Conta?  ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5), // espaço entre os dois textos
                      GestureDetector(
                        child: const Text(
                          'Iniciar Sessão',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // função a ser executada quando o texto é tocado
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
