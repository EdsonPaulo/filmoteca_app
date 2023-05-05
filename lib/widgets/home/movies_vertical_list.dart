import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/widgets/shared/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesVerticalList extends StatelessWidget {
  final Future<List<MovieModel>> favoriteMovies;

  const MoviesVerticalList({
    super.key,
    required this.favoriteMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 16),
      SizedBox(
        height: 570,
        child: FutureBuilder<List<MovieModel>>(
          future: favoriteMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MovieModel> movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: ((context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: AppColors.darkSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(movies[index].coverImgUrl),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                      child: MovieCard(
                        movie: movies[index],
                        width: 346,
                        height: 135,
                        showInfo: false,
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
        ),
      ),
    ]);
  }
}
