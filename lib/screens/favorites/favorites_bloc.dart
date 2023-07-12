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
    } catch (e) {
      _favoriteList = [];
      print('fetchDataFromApi error: $e');
    }
  }

  void addToFavorites(MovieModel movie) {
    if (!isFavoriteMovie(movie.id)) {
      _favoriteList.add(movie);
      saveFavoritesDataOnStorage(_favoriteList);
      _favoritesController.add(List<MovieModel>.from(_favoriteList));
      //saveFavoritesDataOnStorage(_favoriteList);
    }
  }

  void removeFromFavorites(MovieModel movie) {
    _favoriteList.removeWhere((element) => element.id == movie.id);
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

  void getFavoritesFromStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? movieDataJson =
          prefs.getString(SharedPreferencesKeys.favoritesData);
      print(
          'oos filmes: ${prefs.getString(SharedPreferencesKeys.favoritesData)}');
      if (movieDataJson != null) {
        print('if');
        dynamic decodedData = jsonDecode(movieDataJson);

        if (decodedData is List<dynamic>) {
          List<MovieModel> movieData = decodedData
              .map((movieMap) => MovieModel.fromJson(movieMap))
              .toList();

          print('lista $movieData');
          _favoritesController.add(List<MovieModel>.from(movieData));
        } else if (decodedData is Map<String, dynamic>) {
          MovieModel movie = MovieModel.fromJson(decodedData);
          _favoritesController.add([movie]);
        } else {
          print(
              'Invalid data format. Expected a List<dynamic> or Map<String, dynamic>.');
          // Handle the error or use a default value
        }
      } else {
        print('else');

        List<MovieModel> vazia = [];
        _favoritesController.add(List<MovieModel>.from(vazia));
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _favoritesController.close();
  }
}
