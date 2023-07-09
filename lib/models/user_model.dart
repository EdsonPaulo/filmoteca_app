import 'package:filmoteca_app/models/movie_model.dart';

class UserModel {
  String id;
  String name;
  String email;
  String? photoUrl;
  List<MovieModel>? favorites;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.favorites,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'favorites': favorites,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      favorites: json['favorites'] as List<MovieModel>?,
    );
  }
}
