import 'package:filmoteca_app/utils/app_colors.dart';
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                    backgroundColor: AppColors.primaryColor,
                    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                    minimumSize: const Size(325.0, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                    backgroundColor: Colors.white,
                    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                    minimumSize: const Size(325.0, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
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
