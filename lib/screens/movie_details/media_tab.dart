import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaTab extends StatefulWidget {
  final int movieId;

  const MediaTab(this.movieId, {super.key});

  @override
  _MediaTab createState() => _MediaTab();
}

class _MediaTab extends State<MediaTab> {
  late Future<List<MovieTrailerModel>> _movieVideoFuture;

  @override
  void initState() {
    super.initState();
    _movieVideoFuture = fetchVideosByMovieId(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieTrailerModel>>(
      future: _movieVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Ocorreu um erro no carregamento. \n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 24),
            ),
          );
        } else {
          List<MovieTrailerModel> moviesVideos = snapshot.data!;
          return SizedBox(
            height: 400,
            child: GridView.builder(
              itemCount: moviesVideos.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: [
                    Container(
                      width: 115,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.darkSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      moviesVideos[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (50 * MediaQuery.of(context).devicePixelRatio),
              ),
            ),
          );
        }
      },
    );
  }
}
