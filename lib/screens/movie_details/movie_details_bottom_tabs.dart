import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/movie_details/reviews/reviews_tab.dart';
import 'package:filmoteca_app/screens/movie_details/media/media_tab.dart';
import 'package:filmoteca_app/screens/movie_details/suggestions/suggestions_tab.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MovieDetailsTabs extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailsTabs(this.movie, {super.key});

  @override
  _MovieDetailsTabsState createState() => _MovieDetailsTabsState();
}

class _MovieDetailsTabsState extends State<MovieDetailsTabs> {
  int _selectedIndex = 0;
  late Future<MovieModel> _movieFuture;

  @override
  void initState() {
    super.initState();
    _movieFuture = fetchMovieById(widget.movie.id);
  }

  Widget _buildTab(String text, int index) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.greenAccent,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _selectedIndex == index
                  ? AppColors.primaryColor
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return MediaTab(movieId: widget.movie.id);
      case 1:
        return ReviewsTab(movieId: widget.movie.id);
      case 2:
        return SuggestionsTab(movieId: widget.movie.id);
      default:
        return Container();
    }
  }

  double _calculateBorderPosition(int selectedIndex) {
    return ((MediaQuery.of(context).size.width / 3) - 5) * selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTab('Vídeos', 0),
                _buildTab('Avaliações', 1),
                _buildTab('Sugestões', 2),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _calculateBorderPosition(_selectedIndex),
              bottom: 0,
              child: Container(
                width: (MediaQuery.of(context).size.width) / 3 - 10,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: AppColors.primaryColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        IndexedStack(
          index: _selectedIndex,
          children: [
            _buildTabContent(0),
            _buildTabContent(1),
            _buildTabContent(2),
          ],
        ),
      ],
    );
  }
}
