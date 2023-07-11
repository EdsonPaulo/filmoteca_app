import 'dart:convert';
import 'package:filmoteca_app/shared/constants/shared_preferences_keys.dart';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String apiUrl = 'https://filmoteca.onrender.com';

Future<List<ReviewModel>> getReviews({required int movieId}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    final response = await http.get(
      Uri.parse('$apiUrl/reviews/$movieId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    dynamic decodedResponse = jsonDecode(response.body);

    print('getReviews response $decodedResponse');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decodedResponse['data']
          .map((item) => ReviewModel.fromJson(item))
          .toList();
    } else {
      throw http.ClientException(
          decodedResponse['message'] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}

void postReviews(
    {required int movieId,
    required String comment,
    required int rating}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(SharedPreferencesKeys.accessToken);

    final response = await http.post(
      Uri.parse('$apiUrl/reviews'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
          {'movie_id': movieId, 'comment': comment, 'rating': rating}),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 204) {
      throw http.ClientException(
          jsonDecode(response.body)['message'] ?? 'Ocorreu um erro!');
    }
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

    final response = await http.delete(
      Uri.parse('$apiUrl/reviews/$reviewId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 204) {
      throw http.ClientException(
          jsonDecode(response.body)['message'] ?? 'Ocorreu um erro!');
    }
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception(e);
  }
}
