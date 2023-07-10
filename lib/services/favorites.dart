import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/movie_model.dart';

const String apiUrl = 'https://filmoteca.onrender.com';

Future<MovieModel?> postFavorite({required int movieId}) async {
  try {
    final response = await http.post(Uri.parse('$apiUrl/favorites/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'movie_id': movieId}));
    dynamic decodedResponse = jsonDecode(response.body);
    print('postAddFavorites response $decodedResponse');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MovieModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw http.ClientException(
          decodedResponse['message'] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    print(e.toString());
    throw Exception(e);
  }
}

Future<List<MovieModel>> getFavorites() async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/favorites/'),
      headers: {'Content-Type': 'application/json'},
    );

    List<dynamic> decodedResponse = jsonDecode(response.body)['data'];

    print('getFavorites response $decodedResponse');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return decodedResponse
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw http.ClientException(
          decodedResponse['message' as int] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    print(e.toString());
    throw Exception(e);
  }
}

Future<MovieModel> deleteFavorite({required int movieId}) async {
  try {
    final response = await http.delete(
      Uri.parse('$apiUrl/favorites/$movieId'),
      headers: {'Content-Type': 'application/json'},
    );

    dynamic decodedResponse = jsonDecode(response.body)['data'];

    print('deleteFavorite response $decodedResponse');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return decodedResponse
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw http.ClientException(
          decodedResponse['message'] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    print(e.toString());
    throw Exception(e);
  }
}
