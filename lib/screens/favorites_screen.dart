import 'package:filmoteca_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/constants/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: const CustomHomeAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                'FAVORITOS',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
