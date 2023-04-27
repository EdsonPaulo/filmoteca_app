import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final String image = 'assets/images/onboarding_bg.png';

  List<String> images = [
    'assets/images/onboarding_bg.png',
    'assets/images/onboarding_bg.png',
    'assets/images/onboarding_bg.png',
  ];

  final List<String> titles = [
    'Bem-Vindo à Filmoteca',
    'Organize seus filmes favoritos',
    'Compartilhe suas avaliações'
  ];

  final List<String> descriptions = [
    'O melhor aplicativo de catalogação e avaliação de filmes',
    'Adicione seus filmes favoritos e crie listas personalizadas',
    'Compartilhe sua opinião com amigos e descubra novos filmes'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  Color.fromRGBO(0, 237, 123, 0.07),
                  Color.fromRGBO(40, 117, 80, 0.04),
                  Color.fromRGBO(0, 19, 10, 0.6),
                ],
                stops: [
                  0.0,
                  0.2969,
                  0.6771,
                ],
              ),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              flex: 3,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          titles[index],
                          style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            descriptions[index],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 120),
                        if (index == 2)
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 67.0, left: 25.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 325.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF59D75F),
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0, 4),
                                          blurRadius: 4.0,
                                        ),
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0, 4),
                                          blurRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/welcome');
                                      },
                                      child: const Text(
                                        'Continuar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                },
                pagination: const SwiperPagination(),
                //control: SwiperControl(),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
