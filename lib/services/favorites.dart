import 'dart:convert';
import 'package:filmoteca_app/shared/constants/shared_preferences_keys.dart';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String apiUrl = 'https://filmoteca.onrender.com';

Future<List<MovieModel>> getFavorites() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    final response = await http.get(
      Uri.parse('$apiUrl/favorites'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    List<dynamic> decodedResponse = jsonDecode(response.body)['data'];

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decodedResponse
          .map((item) => MovieModel.fromJson(item['movie_data']))
          .toList();
    } else {
      throw http.ClientException(decodedResponse[0] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> postFavorite({required int movieId}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    await http.post(
      Uri.parse('$apiUrl/favorites'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode({'movie_id': movieId}),
    );
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> deleteFavorite({required int movieId}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    await http.delete(
      Uri.parse('$apiUrl/favorites/$movieId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}
