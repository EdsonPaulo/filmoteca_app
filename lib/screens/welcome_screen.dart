import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

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
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 237, 123, 0.00),
                Color.fromRGBO(3, 103, 55, 0.28),
                Color.fromRGBO(1, 1, 1, 0.76),
              ],
              stops: [
                0.0,
                0.01,
                0.0002,
              ],
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/logoA.png'),
          const SizedBox(height: 150)
        ]),
        Container(
          margin: const EdgeInsets.only(top: 500, left: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xff59d75f), // Define a cor de fundo do botão como #59D75F
                  elevation: 4.0, // Define a elevação do box-shadow
                  shadowColor: const Color.fromRGBO(
                      0, 0, 0, 0.25), // Define a cor do box-shadow
                  shape: RoundedRectangleBorder(
                    // Define o border-radius
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  minimumSize: const Size(
                      325.0, 50.0), // Define o tamanho mínimo do botão
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
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
                  backgroundColor: const Color.fromARGB(255, 255, 255,
                      255), // Define a cor de fundo do botão como #59D75F
                  elevation: 4.0, // Define a elevação do box-shadow
                  shadowColor: const Color.fromRGBO(
                      0, 0, 0, 0.25), // Define a cor do box-shadow
                  shape: RoundedRectangleBorder(
                    // Define o border-radius
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  minimumSize: const Size(
                      325.0, 50.0), // Define o tamanho mínimo do botão
                ),
                child: const Text(
                  'Cadastro',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18.0,
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
    );
  }
}
