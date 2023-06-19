import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

const int maxCardsNumber = 5;

class TrendMoviesCarousel extends StatelessWidget {
  final Future<List<MovieModel>> futureMovies;

  const TrendMoviesCarousel({
    super.key,
    required this.futureMovies,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movies = (snapshot.data!);
          movies.shuffle();
          return Swiper(
            itemHeight: 180,
            itemCount: maxCardsNumber,
            viewportFraction: 0.8,
            scale: 0.9,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/movie_details',
                    arguments: movies[index],
                  );
                },
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.darkSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(movies[index].coverImgUrl),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              size: 14,
                              CupertinoIcons.star_fill,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movies[index].rating.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, top: 15, right: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0.1),
                              Color.fromRGBO(0, 0, 0, 0.6),
                              Color.fromRGBO(0, 0, 0, 0.8),
                            ],
                            stops: [
                              0.0,
                              0.4,
                              0.8,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              movies[index].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              movies[index]
                                  .categories
                                  .take(3)
                                  .map((c) => capitalizeText(c))
                                  .join(', '),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            pagination: SwiperPagination(
              builder: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
                  return Transform.translate(
                    offset: const Offset(0, 35),
                    child: const DotSwiperPaginationBuilder(
                      color: Colors.white70,
                      activeColor: AppColors.primaryColor,
                    ).build(context, config),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Ocorreu um erro no carregamento: \n${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        }
        // Enquanto os dados não são carregados, exibir um indicador de carregamento
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
