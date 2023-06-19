import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalList extends StatelessWidget {
  final Future<List<MovieModel>> futureMovies;
  final String title;

  const MoviesHorizontalList({
    super.key,
    required this.futureMovies,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Ver mais',
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 13),
                ),
              )
            ],
          )),
      const SizedBox(height: 16),
      SizedBox(
        height: 170,
        child: FutureBuilder<List<MovieModel>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MovieModel> movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: ((context, index) => Container(
                      margin: const EdgeInsets.only(right: 14),
                      child: MovieCard(
                        movie: movies[index],
                        width: 130,
                        height: 170,
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
