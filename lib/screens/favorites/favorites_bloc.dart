import 'dart:async';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/favorites.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc {
  final _favoritesController = BehaviorSubject<List<MovieModel>>();
  Stream<List<MovieModel>> get favorites => _favoritesController.stream;

  List<MovieModel> _favoriteList = [];

  void fetchDataFromApi() async {
    try {
      List<MovieModel> apiData = await getFavorites();
      _favoriteList = apiData;
    } catch (e) {
      _favoriteList = [];
      print('fetchDataFromApi error: $e');
    }
  }

  void addToFavorites(MovieModel movie) {
    if (!isFavoriteMovie(movie.id)) {
      _favoriteList.add(movie);
      _favoritesController.add(List<MovieModel>.from(_favoriteList));
    }
  }

  void removeFromFavorites(MovieModel movie) {
    _favoriteList.removeWhere((element) => element.id == movie.id);
    _favoritesController.add(List<MovieModel>.from(_favoriteList));
  }

  bool isFavoriteMovie(int movieId) {
    return _favoriteList.any((movie) => movie.id == movieId);
  }

  void dispose() {
    _favoritesController.close();
  }
}
