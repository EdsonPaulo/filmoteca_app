import 'dart:async';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/logo_a.png'),
        const SizedBox(height: 100),
        const CupertinoActivityIndicator(color: Colors.lightGreen)
      ])),
    );
  }
}
