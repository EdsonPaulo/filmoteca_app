import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final MovieModel movie;
  final double width;
  final double height;
  final Function() onRemove;

  const FavoriteCard({
    super.key,
    required this.onRemove,
    required this.movie,
    this.width = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    final String movieDateOrDuration = movie.duration == null
        ? 'Lançamento: ${movie.releaseDate}'
        : formatDuration(movie.duration);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/movie_details',
          arguments: movie,
        );
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.darkSecondaryColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(movie.posterImgUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      movieDateOrDuration,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      movie.categories
                          .take(2)
                          .map((c) => capitalizeText(c))
                          .join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    const Icon(
                      size: 14,
                      CupertinoIcons.star_fill,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
                  IconButton(
                    icon: const Icon(
                      size: 16,
                      CupertinoIcons.trash,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () => onRemove(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
