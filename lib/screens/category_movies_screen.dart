import 'package:filmoteca_app/data/movies_data.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:filmoteca_app/widgets/shared/movie_card.dart';
import 'package:flutter/material.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryMoviesScreen({super.key, required this.category});

  @override
  _CategoryMoviesScreenState createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  List<MovieModel> _movies = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _movies = getTrendMovies();
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
                      children: const [
                        Text(
                          'Ordenar por:  ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          'Popularidade',
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 12),
                        )
                      ],
                    )
                  ],
                )),
            Expanded(
              child: GridView.builder(
                itemCount: _movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return MovieCard(movie: _movies[index], showInfo: true);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (150 * MediaQuery.of(context).devicePixelRatio),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
