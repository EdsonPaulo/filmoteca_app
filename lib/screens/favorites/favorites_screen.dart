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
  late Future<List<MovieModel>> favoriteMovies;

  @override
  void initState() {
    super.initState();
    _favoritesBloc.fetchDataFromApi();
    print("Favorite Screen Init");
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
              child: StreamBuilder<List<MovieModel>>(
                stream: _favoritesBloc.favorites,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MovieModel> movies = snapshot.data!;
                    return MoviesVerticalList(favoriteMovies: movies);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Ocorreu um erro no carregamento: \n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 16),
                      ),
                    );
                  }
                  // Enquanto os dados não são carregados, exibir um indicador de carregamento
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
