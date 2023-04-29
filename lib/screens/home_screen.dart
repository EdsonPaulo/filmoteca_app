import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/data/movies_data.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/widgets/home/trend_movies_carousel.dart';
import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:filmoteca_app/widgets/shared/filter_horizontal_list.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> _categories = [];
  List<MovieModel> _trendMovies = [];

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      _categories = [CategoryModel(id: -1, name: 'Tudo'), ...getCategories()];
      _trendMovies = getTrendMovies();
    });
  }

  void handleSelectCategory(int idx) {
    setState(() {
      _selectedCategoryIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkPrimaryColor,
        appBar: const CustomHomeAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              FilterHorizontalList(
                items:
                    _categories.map((category) => category.toJson()).toList(),
                variant: FilterListVariantType.filled,
                itemRemovable: false,
                selectedItemIndex: _selectedCategoryIndex,
                onPressed: (item, idx) {
                  handleSelectCategory(idx);
                },
              ),
              Container(
                  height: 180,
                  margin: const EdgeInsets.symmetric(vertical: 28),
                  child: TrendMoviesCarousel(
                    movies: _trendMovies,
                    onPressed: (movie, index) {
                      // navigate to movie details
                    },
                  )),
            ],
          ),
        ));
  }
}