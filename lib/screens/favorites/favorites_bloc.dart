import 'dart:async';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';

class FavoritesBloc {
  final _favoritesController = StreamController<List<MovieModel>>();
  Stream<List<MovieModel>> get favorites => _favoritesController.stream;

  List<MovieModel> _favoriteList = [];

  void fetchDataFromApi() async {
    try {
      List<MovieModel> apiData = await fetchMovies('now_playing');
      _favoriteList = apiData.sublist(0, 2);
      _favoritesController.sink.add(List<MovieModel>.from(_favoriteList));
    } catch (e) {
      print('fetchDataFromApi: $e');
    }
  }

  void addToFavorites(MovieModel movie) {
    if (!isFavoriteMovie(movie.id)) {
      _favoriteList.add(movie);
      _favoritesController.sink.add(List<MovieModel>.from(_favoriteList));
    }
  }

  void removeFromFavorites(MovieModel movie) {
    _favoriteList.removeWhere((element) => element.id == movie.id);
    _favoritesController.sink.add(List<MovieModel>.from(_favoriteList));
  }

  bool isFavoriteMovie(int movieId) {
    return _favoriteList.any((movie) => movie.id == movieId);
  }

  void dispose() {
    _favoritesController.close();
  }
}
