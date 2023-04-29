import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool showInfo;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.showInfo = false,
    this.width = 160,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: width,
          height: height,
          padding:
              const EdgeInsets.only(left: 14, top: 10, right: 8, bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.darkSecondaryColor,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(movie.posterImgUrl),
              fit: BoxFit.fill,
              colorFilter: showInfo
                  ? ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.srcATop,
                    )
                  : null,
            ),
          ),
          child: showInfo
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Icon(
                        size: 14,
                        CupertinoIcons.star_fill,
                        color: Colors.yellow,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          movie.categories
                              .take(2)
                              .map((c) => capitalizeText(c))
                              .join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )
              : null),
    );
  }
}
