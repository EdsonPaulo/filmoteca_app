import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final MovieModel movie;
  final bool showInfo;
  final double width;
  final double height;

  const FavoriteCard({
    super.key,
    required this.movie,
    this.showInfo = false,
    this.width = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: width,
          height: height,
          padding:
              const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
          child: showInfo
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 14),
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.darkSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(movie.posterImgUrl),
                          fit: BoxFit.cover,
                          colorFilter: showInfo
                              ? ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.srcATop,
                                )
                              : null,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          movie.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          movie.duration.toString(),
                          style: const TextStyle(
                              fontSize: 12,
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
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                      const SizedBox(width: 60),


                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Row(children: [
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
                      const SizedBox(height: 60),
                      const Icon(
                        size: 16,
                        CupertinoIcons.bin_xmark,
                        color: AppColors.primaryColor,
                      ),
                    ])
                  ],
                )
              : null),
    );
  }
}
