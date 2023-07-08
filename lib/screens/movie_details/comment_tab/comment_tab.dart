import 'package:filmoteca_app/screens/movie_details/comment_tab/comment_card.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentTab extends StatefulWidget {
  final int movieId;

  const CommentTab({super.key, required this.movieId});

  @override
  _CommentTab createState() => _CommentTab();
}

class _CommentTab extends State<CommentTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 50,
        child: RatingBar(
          minRating: 0,
          maxRating: 5,
          initialRating: 0,
          allowHalfRating: true,
          onRatingUpdate: (rating) {
            print('Rating: $rating');
          },
          glowColor: Colors.amber,
          glowRadius: 5,
          glow: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          ratingWidget: RatingWidget(
            full: const Icon(
              CupertinoIcons.star_fill,
              color: Colors.yellow,
            ),
            half: const Icon(
              CupertinoIcons.star_lefthalf_fill,
              color: Colors.yellow,
            ),
            empty: const Icon(CupertinoIcons.star, color: Colors.yellow),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Deixe seu comentário...',
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFF2A2D38),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
                iconSize: 24,
                icon: const Icon(
                  CupertinoIcons.paperplane,
                  color: Colors.white,
                ),
                onPressed: () {
                  //Send Comment action
                }),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Comentários (3)',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          CommentCard(),
          CommentCard(),
          CommentCard(),
        ],
      )
    ]);
  }
}
