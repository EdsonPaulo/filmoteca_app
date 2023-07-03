import 'package:filmoteca_app/models/movie_model.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String? photoUrl;
  List<MovieModel>? favorites;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.favorites,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'favorites': favorites,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      favorites: json['favorites'] as List<MovieModel>?,
    );
  }
}
