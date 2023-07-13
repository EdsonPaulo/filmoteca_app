import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  _ReviewCard createState() => _ReviewCard();
}

class _ReviewCard extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.accentColor,
                  child: Text(
                    getNameInitials(widget.review.userName),
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.review.userEmail ?? '-',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.yellow,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  '${widget.review.rating}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (widget.review.comment.isNotEmpty)
          Text(
            widget.review.comment,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              widget.review.createdAt,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
