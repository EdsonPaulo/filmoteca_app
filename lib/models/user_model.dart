import 'package:filmoteca_app/models/movie_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String? accessToken;
  List<MovieModel>? favorites;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.accessToken,
    this.favorites,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'favorites': favorites,
      'accessToken': accessToken
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      accessToken: json['access_token'] as String?,
      favorites: json['favorites'] as List<MovieModel>?,
    );
  }
}
