import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/favorites/favorites_bloc.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:get_it/get_it.dart';

import 'movies_vertical_list.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesBloc favoritesBloc = GetIt.instance<FavoritesBloc>();

  Future<void> handleRefresh() async {
    favoritesBloc.fetchDataFromApi();
    return;
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
              child: RefreshIndicator(
                onRefresh:
                    handleRefresh, // Sua função de tratamento de atualização
                child: StreamBuilder<List<MovieModel>>(
                  stream: favoritesBloc.favorites,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MovieModel> movies = snapshot.data!;
                      if (movies.isEmpty) {
                        return const Center(
                          child: Text(
                            'A tua lista de favoritos está vazia!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
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
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
