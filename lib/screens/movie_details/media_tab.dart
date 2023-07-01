import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/services/get_movies.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaTab extends StatefulWidget {
  final int movieId;

  const MediaTab(this.movieId, {super.key});

  @override
  _MediaTab createState() => _MediaTab();
}

class _MediaTab extends State<MediaTab> {
  late Future<List<List<MovieTrailerModel>>> _movieMidia;

  @override
  void initState() {
    super.initState();
    //_movieVideosFuture = fetchVideosByMovieId(movieId: widget.movieId);
    //_movieImagesFuture = fetchImagesByMovieId(movieId: widget.movieId);

    _movieMidia = fetchMediaByMovieId(movieId: widget.movieId);
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<MovieTrailerModel>>>(
      future: _movieMidia,
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
          print('imagens: ${moviesImgList.length}');
          print('videos: ${moviesVidList.length}');

          return SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: moviesImgList.length < moviesVidList.length
                  ? moviesImgList.length
                  : moviesVidList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final videoUrl = Uri(
                              scheme: 'https',
                              host: 'youtube.com',
                              path: '/watch',
                              queryParameters: {
                                'v': moviesVidList[index].videoKey
                              });

                          print(videoUrl);
                          _launchURL(videoUrl);
                        },
                        child: Container(
                          width: 115,
                          height: 70,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.darkSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(moviesImgList[index].imgUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.play_fill,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          moviesVidList[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
