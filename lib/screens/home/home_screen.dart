import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/models/filter_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';
import 'package:filmoteca_app/shared/widgets/filter_horizontal_list.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:filmoteca_app/shared/widgets/movies_horizontal_list.dart';
import 'package:filmoteca_app/screens/home/trend_movies_carousel.dart';

// http://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<FilterModel> _categories = [
    FilterModel(id: "-1", name: 'Tudo', type: FilterType.category),
    ...getCategories().map(
        (e) => FilterModel(id: e.id, name: e.name, type: FilterType.category))
  ];
  late Future<List<MovieModel>> _popularMovies;
  late Future<List<MovieModel>> _newMovies;
  late Future<List<MovieModel>> _topRatedMovies;
  late Future<List<MovieModel>> _upcomingMovies;

  String _selectedCategoryIndex = '-1';

  @override
  void initState() {
    super.initState();

    setState(() {
      _newMovies = fetchMovies('now_playing');
      _popularMovies = fetchMovies('popular');
      _topRatedMovies = fetchMovies('top_rated');
      _upcomingMovies = fetchMovies('upcoming');
    });
  }

  void handleSelectCategory(String index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: const CustomHomeAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            FilterHorizontalList(
              items: _categories,
              variant: FilterListVariantType.filled,
              itemRemovable: false,
              selectedItems: const [],
              onPressed: (item, idx) {
                handleSelectCategory(item.id);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    margin: const EdgeInsets.only(top: 20, bottom: 50),
                    child: TrendMoviesCarousel(
                      futureMovies: _newMovies,
                    ),
                  ),
                  MoviesHorizontalList(
                    title: 'Últimas Novidades',
                    futureMovies: _newMovies,
                  ),
                  const SizedBox(height: 24),
                  MoviesHorizontalList(
                    title: 'Mais Populares',
                    futureMovies: _popularMovies,
                  ),
                  const SizedBox(height: 24),
                  MoviesHorizontalList(
                    title: 'Mais Votados',
                    futureMovies: _topRatedMovies,
                  ),
                  const SizedBox(height: 24),
                  MoviesHorizontalList(
                    title: 'Brevemente',
                    futureMovies: _upcomingMovies,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
