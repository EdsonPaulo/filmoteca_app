import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_button.dart';
import 'package:filmoteca_app/shared/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF181A1F),
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.darkPrimaryColor,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
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
                CustomTextField(
                  label: 'Nome e Sobrenome',
                  leftIcon: CupertinoIcons.person,
                  onChangeText: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Email',
                  leftIcon: CupertinoIcons.mail,
                  onChangeText: (val) {
                    setState(() {
                      _email = val;
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  isPassword: true,
                  label: 'Palavra-Passe',
                  leftIcon: Icons.lock_outline,
                  onChangeText: (val) {
                    setState(() {
                      _password = val;
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  isPassword: true,
                  label: 'Confirmar Palavra-passe',
                  leftIcon: Icons.lock_outline,
                  onChangeText: (val) {
                    setState(() {
                      _password = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                    label: 'Entrar',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    }),
                const SizedBox(height: 70),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Já tem uma Conta?  ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 5), // espaço entre os dois textos
                        Text(
                          'Iniciar Sessão',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    )),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      }),
    );
  }
}
