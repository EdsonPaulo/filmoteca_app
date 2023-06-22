import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/screens/favorites/favorite_movie_card.dart';
import 'package:flutter/material.dart';

class MoviesVerticalList extends StatelessWidget {
  final List<MovieModel> favoriteMovies;

  const MoviesVerticalList({
    super.key,
    required this.favoriteMovies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteMovies.length,
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
              movie: favoriteMovies[index],
              height: 135,
            ),
          )),
    );
  }
}
