import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:filmoteca_app/shared/widgets/movie_card.dart';
import 'package:flutter/material.dart';

import './sort_by_dropdown.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryMoviesScreen({super.key, required this.category});

  @override
  _CategoryMoviesScreenState createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  late Future<List<MovieModel>> _moviesFuture;
  String _selectedSortBy = 'popularity.desc';

  @override
  void initState() {
    super.initState();
    setState(() {
      _moviesFuture = fetchMoviesByCategoryId(
        categoryId: widget.category.id,
        sortBy: _selectedSortBy,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: AppBar(
          elevation: 0,
          foregroundColor: AppColors.primaryColor,
          backgroundColor: AppColors.darkPrimaryColor),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeText(widget.category.name),
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Ordenar por:',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        SortByDropdown(
                          selectedSortBy: _selectedSortBy,
                          onSortChanged: (String newValue) {
                            setState(() {
                              _selectedSortBy = newValue;
                              _moviesFuture = fetchMoviesByCategoryId(
                                categoryId: widget.category.id,
                                sortBy: _selectedSortBy,
                              );
                            });
                          },
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
              child: FutureBuilder<List<MovieModel>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Ocorreu um erro no carregamento. \n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 24),
                      ),
                    );
                  } else {
                    List<MovieModel> movies = snapshot.data!;
                    return GridView.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieCard(movie: movies[index], showInfo: true);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (150 * MediaQuery.of(context).devicePixelRatio),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
