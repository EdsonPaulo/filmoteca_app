import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/favorites/favorites_bloc.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

import 'movies_vertical_list.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favoritesBloc = FavoritesBloc();

  @override
  void initState() {
    super.initState();
    _favoritesBloc.fetchDataFromApi();
  }

  @override
  void dispose() {
    _favoritesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: const CustomHomeAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.topCenter,
              child: const Text(
                'Meus Favoritos',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: MoviesVerticalList(),
            )
          ],
        ),
      ),
    );
  }
}
