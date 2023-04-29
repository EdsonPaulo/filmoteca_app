import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/models/movie_model.dart';

List<MovieModel> getTrendMovies() {
  List<MovieModel> movies = [];

  movies.add(MovieModel(
      id: 1,
      title: 'John Wick',
      coverImgUrl: 'https://loremflickr.com/321/241/movie,horror',
      synopsis: 'Lorem ipsum odor merun.',
      duration: 0,
      rating: 7.0,
      liked: false,
      images: [],
      cast: [],
      categories: getCategories().sublist(0, 3),
      reviews: [],
      trailers: []));

  movies.add(MovieModel(
    id: 2,
    title: 'Ludo Ghost',
    coverImgUrl: 'https://loremflickr.com/322/242/movie,action',
    synopsis: 'Lorem ipsum odor merun.',
    rating: 9.5,
    categories: getCategories().sublist(2, 3),
  ));

  movies.add(MovieModel(
    id: 3,
    title: 'Flop Fantasma - Anime',
    coverImgUrl: 'https://loremflickr.com/333/343/movie,anime',
    synopsis: 'Lorem ipsum odor merun.',
    rating: 5.4,
    categories: getCategories().sublist(0, 2),
  ));

  movies.add(MovieModel(
    id: 4,
    title: 'Floresta Amazônia Documentario',
    coverImgUrl: 'https://loremflickr.com/343/344/movie,nature',
    synopsis: 'Lorem ipsum odor merun.',
    rating: 8.7,
    categories: getCategories().sublist(1, 3),
  ));

  return movies;
}
