import 'package:filmoteca_app/widgets/shared/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final String image = 'assets/images/onboarding_bg.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Bem-Vindo')),
      body: Stack(children: [
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
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 100),
          Image.asset('assets/images/logo_a.png'),
          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    label: 'Entrar',
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                const SizedBox(height: 20),
                CustomButton(
                    label: 'Criar Conta',
                    variant: ButtonVariantType.secondary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text('Início'),
                ),
              ],
            ),
          )
        ]),
      ]),
    );
  }
}
