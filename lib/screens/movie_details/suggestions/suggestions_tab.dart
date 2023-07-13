import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/shared/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class SuggestionsTab extends StatefulWidget {
  final int movieId;

  const SuggestionsTab({super.key, required this.movieId});

  @override
  _SuggestionsTab createState() => _SuggestionsTab();
}

class _SuggestionsTab extends State<SuggestionsTab> {
  late Future<List<MovieModel>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    setState(() {
      _moviesFuture = fetchMovieRecommendations(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
              future: _moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Ocorreu um erro no carregamento. \n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.redAccent, fontSize: 24),
                    ),
                  );
                } else {
                  List<MovieModel> movies = snapshot.data!;
                  return GridView.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MovieCard(movie: movies[index], showInfo: true);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (150 * MediaQuery.of(context).devicePixelRatio),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
