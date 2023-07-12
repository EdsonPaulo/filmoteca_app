import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/movie_details/media/media_tab_list.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:flutter/material.dart';

class MediaTab extends StatefulWidget {
  final int movieId;

  const MediaTab({super.key, required this.movieId});

  @override
  _MediaTab createState() => _MediaTab();
}

class _MediaTab extends State<MediaTab> {
  late Future<List<List<MovieTrailerModel>>> _movieMedia;

  @override
  void initState() {
    super.initState();
    _movieMedia = fetchMediaByMovieId(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<MovieTrailerModel>>>(
      future: _movieMedia,
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
          List<List<MovieTrailerModel>> moviesVideos = snapshot.data!;
          List<MovieTrailerModel> moviesImgList = moviesVideos[0];
          List<MovieTrailerModel> moviesVidList = moviesVideos[1];

          return MediaTabList(
            moviesImgList: moviesImgList,
            moviesVidList: moviesVidList,
          );
        }
      },
    );
  }
}
