import 'dart:async';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';

class FavoritesBloc {
  final _favoritesController = StreamController<List<MovieModel>>();

  StreamSink<List<MovieModel>> get _inputFavorites => _favoritesController.sink;
  Stream<List<MovieModel>> get favorites => _favoritesController.stream;

  final List<MovieModel> _favoriteList = [];

  void fetchDataFromApi() async {
    List<MovieModel> apiData = await fetchMovies('now_playing');
    _favoritesController.add(apiData);
  }

  void addToFavorites(MovieModel movie) {
    if (!isFavoriteMovie(movie.id)) {
      _favoriteList.add(movie);
      _inputFavorites.add(_favoriteList);
      _favoritesController.add(_favoriteList);
    }
  }

  void removeFromFavorites(MovieModel movie) {
    if (isFavoriteMovie(movie.id)) {
      _favoriteList.remove(movie);
      _inputFavorites.add(_favoriteList);
    }
  }

  bool isFavoriteMovie(int movieId) {
    return _favoriteList.any((movie) => movie.id == movieId);
  }

  void dispose() {
    _favoritesController.close();
  }
}
