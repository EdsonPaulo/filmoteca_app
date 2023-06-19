import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_button.dart';
import 'package:filmoteca_app/shared/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.darkPrimaryColor,
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/logo_b.png'),
              const SizedBox(height: 30),
              const Text(
                'Iniciar Sessão',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 20),
              CustomButton(
                  label: 'Entrar',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  }),
              const SizedBox(height: 70),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Não tem uma Conta?',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5), // espaço entre os dois textos
                      Text(
                        'Criar Conta',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ],
                  )),
              const SizedBox(height: 70),
            ]),
          ),
        );
      }),
    );
  }
}
