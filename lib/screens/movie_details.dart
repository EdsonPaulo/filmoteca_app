import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieModel _movie;

  @override
  void initState() {
    super.initState();

    setState(() {
      //  _movie = fetchMovieById(widget.movie.id) as MovieModel;
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
                    capitalizeText(widget.movie.title),
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Ordenar por: ',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
