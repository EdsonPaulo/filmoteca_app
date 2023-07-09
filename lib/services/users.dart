import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/user_model.dart';

const String apiUrl = 'https://filmoteca.onrender.com';

Future<UserModel?> postSignIn({
  required String email,
  required String password,
}) async {
  try {
    final response = await http.post(Uri.parse('$apiUrl/auth/sign_in'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    print(jsonDecode(response.body));
    return UserModel.fromJson(jsonDecode(response.body)['data']);
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    print(e.toString());
    throw Exception(e);
  }
}

Future<UserModel?> postSignUp({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await http.post(Uri.parse('$apiUrl/auth/sign_up'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }));

    print(jsonDecode(response.body));
    return UserModel.fromJson(jsonDecode(response.body)['data']);
  } on http.ClientException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    print(e.toString());
    throw Exception(e);
  }
}
