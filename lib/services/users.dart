import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:filmoteca_app/models/user_model.dart';

const API_URL = 'https://filmoteca.onrender.com';

Future<UserModel?> postSignIn({
  required String email,
  required String password,
}) async {
  try {
    final response =
        await http.post(Uri.parse('$API_URL/sign_in'), headers: {}, body: {
      'email': email,
      'password': password,
    });
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['data'] as UserModel;
  } catch (e) {
    print(e);
    throw Exception(e);
  }
}

Future<UserModel?> postSignUp({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response =
        await http.post(Uri.parse('$API_URL/sign_up'), headers: {}, body: {
      'name': name,
      'email': email,
      'password': password,
    });
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['data'] as UserModel;
  } catch (e) {
    print(e);
    throw Exception(e);
  }
}
