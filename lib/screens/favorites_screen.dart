import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

import '../widgets/home/movies_vertical_list.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<MovieModel> _movies = [];
  late Future<List<MovieModel>> _favmovies;

  @override
  void initState() {
    super.initState();
    setState(() {
      _movies = [];
      _favmovies = fetchMovies('now_playing');
    });
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
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: MoviesVerticalList(favoriteMovies: _favmovies),
            )
          ],
        ),
      ),
    );
  }
}
