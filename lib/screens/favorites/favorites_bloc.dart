import 'dart:async';
import 'dart:convert';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/favorites.dart';
import 'package:filmoteca_app/shared/constants/shared_preferences_keys.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc {
  final _favoritesController = BehaviorSubject<List<MovieModel>>();
  Stream<List<MovieModel>> get favorites => _favoritesController.stream;

  List<MovieModel> _favoriteList = [];

  void fetchDataFromApi() async {
    try {
      List<MovieModel> apiData = await getFavorites();
      _favoriteList = apiData;
      _favoritesController.add(List<MovieModel>.from(_favoriteList));
    } catch (e) {
      _favoriteList = [];
    }
  }

  void addToFavorites(MovieModel movie) {
    if (!isFavoriteMovie(movie.id)) {
      _favoriteList.add(movie);
      postFavoritesFromApi(movie.id);
      _favoritesController.add(List<MovieModel>.from(_favoriteList));
    }
  }

  void removeFromFavorites(MovieModel movie) {
    _favoriteList.removeWhere((element) => element.id == movie.id);
    deleteFavoriteFromApi(movie.id);
    _favoritesController.add(List<MovieModel>.from(_favoriteList));
  }

  bool isFavoriteMovie(int movieId) {
    return _favoriteList.any((movie) => movie.id == movieId);
  }

  void saveFavoritesDataOnStorage(List<MovieModel>? movieData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (movieData != null) {
        List<Map<String, dynamic>> movieList =
            movieData.map((movie) => movie.toJson()).toList();
        String movieDataJson = jsonEncode(movieList);
        await prefs.setString(
            SharedPreferencesKeys.favoritesData, movieDataJson);
      }
    } catch (e) {
      print(e);
    }
  }

  void postFavoritesFromApi(int movieId) async {
    try {
      await postFavorite(movieId: movieId);
    } catch (e) {
      print(e);
    }
  }

  void deleteFavoriteFromApi(int movieId) async {
    try {
      await deleteFavorite(movieId: movieId);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _favoritesController.close();
  }
}
