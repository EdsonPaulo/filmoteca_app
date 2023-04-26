import 'package:filmoteca_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void onDonePress() {
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  final List<String> _onboardingSentences = [
    'O Melhor aplicativo de catalogação e avaliação de filmes',
    'Texto 2',
    'Texto 3',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/onboarding_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Bem-Vindo à Filmoteca',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.white,
                  fontSize: 28,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 170,
              child: PageView.builder(
                itemCount: 3,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _onboardingSentences[_currentPage],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'RobotoSlab',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 10),
                            child: (index < 2)
                                ? Material(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            _pageController.animateToPage(
                                              _currentPage + 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          icon: const Icon(Icons.arrow_forward),
                                          color: Colors.white,
                                          iconSize: 30,
                                        )))
                                : ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/welcome');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          return AppColors.primaryColor;
                                        },
                                      ),
                                    ),
                                    child: const Text('Continuar'),
                                  ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentPage == 0
                          ? AppColors.primaryColor
                          : Colors.white70,
                    )),
                Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentPage == 1
                          ? AppColors.primaryColor
                          : Colors.white70,
                    )),
                Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentPage == 2
                          ? AppColors.primaryColor
                          : Colors.white70,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
