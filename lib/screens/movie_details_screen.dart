import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:filmoteca_app/widgets/home/movie_details_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieModel> _movieFuture;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _movieFuture = fetchMovieById(widget.movie.id);
  }

  Widget _renderIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.darkSecondaryColor,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: Colors.greenAccent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderChipInfo(String label, IconData? icon) {
    return Chip(
      elevation: 1.0,
      backgroundColor: AppColors.darkSecondaryColor,
      avatar: icon != null
          ? CircleAvatar(
              backgroundColor: AppColors.darkSecondaryColor,
              child: Icon(icon, size: 12, color: Colors.yellow),
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: icon == null ? const EdgeInsets.all(1.0) : null,
      labelPadding:
          icon != null ? const EdgeInsets.only(right: 6, left: 0) : null,
      label: Text(
        label,
        style: const TextStyle(
            fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }

  void _handleShareMovie(MovieModel movie) {
    String copy = '${movie.title}\n\n'
        'Data de lançamento: ${movie.releaseDate}\n\n'
        'Gênero: ${movie.categories.join(', ')}\n\n'
        'Sinopse:\n${movie.synopsis}\n\n'
        'Saiba mais em: https://www.themoviedb.org/movie/${movie.id}';
        
    Share.share(copy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      body: FutureBuilder<MovieModel>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                ' Ocorreu um erro no carregamento. \n${snapshot.error} ',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 24),
              ),
            );
          } else {
            MovieModel movie = snapshot.data!;
            return Stack(
              children: [
                Container(
                  height: 305,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.coverImgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _renderIconButton(
                          icon: CupertinoIcons.arrow_left,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        _renderIconButton(
                          icon: CupertinoIcons.share,
                          onTap: () {
                            _handleShareMovie(movie);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.darkPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    movie.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                _renderIconButton(
                                  icon: _isLiked
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  onTap: () {
                                    setState(() {
                                      _isLiked = !_isLiked;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 8.0,
                              runSpacing: -10,
                              children: [
                                ...movie.categories
                                    .map<Widget>(
                                        (c) => _renderChipInfo(c, null))
                                    .toList(),
                                _renderChipInfo(
                                    formatDuration(movie.duration ?? 0), null),
                                _renderChipInfo(
                                    double.parse(
                                            movie.rating.toStringAsFixed(1))
                                        .toString(),
                                    CupertinoIcons.star_fill)
                              ],
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Sinopse',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.synopsis,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 15),
                            const MovieDetailsTabs(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
