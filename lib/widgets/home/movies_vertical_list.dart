import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/widgets/shared/favorite_movie_card.dart';
import 'package:flutter/material.dart';

class MoviesVerticalList extends StatelessWidget {
  final Future<List<MovieModel>> favoriteMovies;

  const MoviesVerticalList({
    super.key,
    required this.favoriteMovies,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: favoriteMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            itemBuilder: ((context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: AppColors.darkSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FavoriteCard(
                    movie: movies[index],
                    height: 120,
                  ),
                )),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Ocorreu um erro no carregamento: \n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        }
        // Enquanto os dados não são carregados, exibir um indicador de carregamento
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
