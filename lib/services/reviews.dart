import 'dart:convert';
import 'package:filmoteca_app/shared/constants/shared_preferences_keys.dart';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String apiUrl = 'https://filmoteca.onrender.com';

Future<List<ReviewModel>> fetchMovieReviews({required int movieId}) async {
  try {
    final response = await http.get(Uri.parse('$apiUrl/reviews/$movieId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic>? decodedResponse = jsonDecode(response.body)['data'];
      return decodedResponse
              ?.map((item) => ReviewModel.fromJson(item))
              .toList() ??
          [];
    } else {
      throw http.ClientException(
          jsonDecode(response.body)['message'] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> postReview({
  required int movieId,
  required String comment,
  required double rating,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    await http.post(
      Uri.parse('$apiUrl/reviews/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode({
        'movie_id': movieId,
        'comment': comment,
        'rating': rating,
      }),
    );
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}

void deleteReview({required int reviewId}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    await http.delete(
      Uri.parse('$apiUrl/reviews/$reviewId'),
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
