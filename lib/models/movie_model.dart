/// USER REVIEW
class ReviewModel {
  int id;
  int movieId;
  String userName;
  String? userEmail;
  String comment;
  double rating;
  String createdAt;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.comment,
    required this.movieId,
    this.userEmail,
    this.rating = 0.0,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      movieId: json['movie_id'] as int,
      userName: json['user_name'] as String,
      userEmail: json['user_email'] as String,
      comment: json['comment'] as String,
      rating: json['rating'] as double,
      createdAt: json['created_at'] as String,
    );
  }
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
  String videoKey;
  String imgUrl;
  String? videoUrl;

  MovieTrailerModel(
      {required this.videoKey,
      required this.title,
      required this.imgUrl,
      this.videoUrl});

  factory MovieTrailerModel.fromJson(Map<String, dynamic> json) {
    return MovieTrailerModel(
      title: json['name'],
      videoKey: json['key'],
      imgUrl: 'https://image.tmdb.org/t/p/w500${json['file_path']}',
    );
  }
}

/// MOVIE
class MovieModel {
  int id;
  String title;
  double rating;
  int? duration; // in minutes
  String synopsis;
  String coverImgUrl;
  String posterImgUrl;
  bool liked; // if the current user liked this movie
  String releaseDate;
  String homepage;
  List<String> images;
  List<String> categories;
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
    this.releaseDate = '',
    this.homepage = '',
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': synopsis,
    };
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      rating:
          json['vote_average'] != null ? json['vote_average'].toDouble() : null,
      duration: json['runtime'],
      synopsis: json['overview'],
      releaseDate: json['release_date'],
      homepage: json['homepage'],
      coverImgUrl: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      posterImgUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      images: [],
      categories: json['genres'] != null
          ? ((json['genres']) as List<dynamic>)
              .map((g) => g['name'])
              .toList()
              .cast<String>()
          : json['genre_ids'] != null
              ? ((json['genre_ids']) as List<dynamic>)
                  .map((gId) => genres[gId]!)
                  .toList()
                  .cast<String>()
              : [],
      reviews: [],
      cast: [],
      trailers: [],
    );
  }
}

const genres = {
  28: "Ação",
  12: "Aventura",
  16: "Animação",
  35: "Comédia",
  80: "Crime",
  99: "Documentário",
  18: "Drama",
  10751: "Família",
  14: "Fantasia",
  36: "História",
  27: "Terror",
  10402: "Música",
  9648: "Mistério",
  10749: "Romance",
  878: "Ficção científica",
  10770: "Cinema TV",
  53: "Thriller",
  10752: "Guerra",
  37: "Faroeste",
};
