import 'package:filmoteca_app/models/movie_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'd4c99955213a94283093a6051b4b918d';

Future<List<MovieModel>> fetchMovies(String endpoint) async {
  String apiUrl =
      'https://api.themoviedb.org/3/movie/$endpoint?language=pt-BR&api_key=$apiKey&include_adult=false';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    List<dynamic> moviesJson = jsonDecode(response.body)['results'];
    return moviesJson.map((movie) => MovieModel.fromJson(movie)).toList();
  } catch (e) {
    print('Erro ao buscar filmes: $e');
    throw Exception('Não foi possível buscar os filmes');
  }
}

Future<MovieModel> fetchMovieById(int movieId) async {
  String apiUrl =
      'https://api.themoviedb.org/3/movie/$movieId?language=pt-BR&api_key=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    dynamic movieJson = jsonDecode(response.body);
    return MovieModel.fromJson(movieJson);
  } catch (e) {
    print('Erro ao buscar filmes: $e');
    throw Exception('Filme não encontrado');
  }
}

Future<List<MovieModel>> fetchMoviesByCategoryId({
  required String categoryId,
  required String sortBy,
}) async {
  String apiUrl =
      'https://api.themoviedb.org/3/discover/movie?with_genres=$categoryId&sort_by=$sortBy&language=pt-BR&api_key=$apiKey&include_adult=false';

  print(apiUrl);
  try {
    final response = await http.get(Uri.parse(apiUrl));
    List<dynamic> moviesJson = jsonDecode(response.body)['results'];
    return moviesJson.map((movie) => MovieModel.fromJson(movie)).toList();
  } catch (e) {
    print('Erro ao buscar filmes: $e');
    throw Exception('Não foi possível buscar os filmes');
  }
}

Future<List<MovieTrailerModel>> fetchVideosByMovieId(
    {required int movieId}) async {
  final apiUrl =
      'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    List<dynamic> moviesJson = jsonDecode(response.body)['results'];
    return moviesJson
        .map((movie) => MovieTrailerModel.fromJson(movie))
        .toList();
  } catch (e) {
    print('Erro ao buscar filmes: $e');
    throw Exception('Não foi possível buscar os filmes');
  }
}
