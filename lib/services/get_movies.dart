import 'package:filmoteca_app/models/movie_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'd4c99955213a94283093a6051b4b918d';

Future<List<MovieModel>> fetchMovies(String endpoint) async {
  String apiUrl =
      'https://api.themoviedb.org/3/movie/$endpoint?language=pt-BR&api_key=$apiKey';

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
    dynamic movieJson = jsonDecode(response.body)['results'];
    return MovieModel.fromJson(movieJson);
  } catch (e) {
    print('Erro ao buscar filmes: $e');
    throw Exception('Filme não encontrado');
  }
}
