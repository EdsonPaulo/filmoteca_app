import 'package:filmoteca_app/models/category_model.dart';

/// USER REVIEW
class ReviewModel {
  int id;
  String userName;
  String? userImgUrl;
  String comment;
  double rating;
  int likes;
  bool liked;

  ReviewModel(
      {required this.id,
      required this.userName,
      required this.comment,
      this.rating = 0.0,
      this.userImgUrl,
      this.liked = false,
      this.likes = 0});
}

/// CAST / ELENCO
class MovieCastModel {
  String name;
  String? imgUrl;
  MovieCastModel(this.name, this.imgUrl);
}

/// MOVIE TRAILER
class MovieTrailerModel {
  String title;
  String? imgUrl;
  String? videoUrl;
  MovieTrailerModel(this.title, this.imgUrl, this.videoUrl);
}

/// MOVIE
class MovieModel {
  int id;
  String title;
  double rating;
  int duration; // in minutes
  String synopsis;
  String coverImgUrl;
  String posterImgUrl;
  bool liked; // if the current user liked this movie
  List<String> images;
  List<CategoryModel> categories;
  List<ReviewModel> reviews;
  List<MovieCastModel> cast;
  List<MovieTrailerModel> trailers;

  MovieModel({
    required this.id,
    required this.title,
    required this.coverImgUrl,
    required this.posterImgUrl,
    required this.synopsis,
    this.duration = 0,
    this.rating = 0.0,
    this.liked = false,
    this.images = const [],
    this.cast = const [],
    this.categories = const [],
    this.reviews = const [],
    this.trailers = const [],
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      rating: json['vote_average'].toDouble(),
      duration: json['runtime'],
      synopsis: json['overview'],
      coverImgUrl: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      posterImgUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      images: [], // Você precisará preencher este campo com base na resposta da API
      categories: [], // Preencha este campo com base na resposta da API
      reviews: [], // Preencha este campo com base na resposta da API
      cast: [], // Preencha este campo com base na resposta da API
      trailers: [], // Preencha este campo com base na resposta da API
    );
  }
}
