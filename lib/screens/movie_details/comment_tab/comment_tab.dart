// ignore_for_file: use_build_context_synchronously

import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/movie_details/comment_tab/comment_card.dart';
import 'package:filmoteca_app/services/reviews.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/app_toasts.dart';
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
  late Future<List<ReviewModel>> _movieReviews;
  String comment = '';
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    _movieReviews = fetchMovieReviews(movieId: widget.movieId);
  }

  Future<void> _onSubmitReview(BuildContext context) async {
    await postReview(
      comment: comment,
      movieId: widget.movieId,
      rating: rating,
    );
    showToast(
        context: context,
        message: 'Avaliação enviada com sucesso!',
        type: ToastType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: RatingBar(
            minRating: 0,
            maxRating: 5,
            initialRating: rating,
            allowHalfRating: true,
            onRatingUpdate: (val) {
              setState(() {
                rating = val;
              });
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
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    comment = val;
                  });
                },
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
            const SizedBox(width: 10),
            Material(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () {
                  _onSubmitReview(context);
                },
                borderRadius: BorderRadius.circular(50),
                splashColor: Colors.greenAccent,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(
                      CupertinoIcons.paperplane,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        FutureBuilder<List<ReviewModel>>(
          future: _movieReviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ocorreu um erro no carregamento. \n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              );
            } else {
              List<ReviewModel> reviews = snapshot.data ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comentários (${reviews.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  ...reviews.map((r) => CommentCard(review: r)),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
