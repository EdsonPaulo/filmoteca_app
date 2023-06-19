import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:filmoteca_app/shared/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;

  final List<String> _titles = [
    'Bem-Vindo à Filmoteca',
    'Organize seus Filmes Favoritos',
    'Avalie os Melhores Filmes'
  ];

  final List<String> _descriptions = [
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg.png'),
                fit: BoxFit.fill,
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
                onIndexChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                itemCount: _titles.length,
                loop: false,
                controller: _swiperController,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _titles[index],
                          style: const TextStyle(
                              fontSize: 26,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _descriptions[index],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                pagination:
                    const SwiperPagination(margin: EdgeInsets.only(bottom: 50)),
                //control: SwiperControl(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: _currentIndex == 2
                    ? CustomButton(
                        label: 'Continuar',
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _swiperController.next();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 4.0,
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                          minimumSize: const Size(50, 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.white,
                        ),
                      )),
          ]),
        ],
      ),
    );
  }
}
