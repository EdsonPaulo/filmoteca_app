// ignore_for_file: use_build_context_synchronously
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/screens/movie_details/reviews/review_card.dart';
import 'package:filmoteca_app/services/reviews.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/app_toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsTab extends StatefulWidget {
  final int movieId;

  const ReviewsTab({super.key, required this.movieId});

  @override
  _ReviewsTab createState() => _ReviewsTab();
}

class _ReviewsTab extends State<ReviewsTab> {
  late Future<List<ReviewModel>> _movieReviews;
  final TextEditingController _commentController = TextEditingController();
  double rating = 0.0;
  bool isSubmitButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _movieReviews = fetchMovieReviews(movieId: widget.movieId);
    });
  }

  Future<void> _onSubmitReview(BuildContext context) async {
    if (isSubmitButtonEnabled) {
      try {
        await postReview(
          comment: _commentController.text,
          movieId: widget.movieId,
          rating: rating,
        );
        setState(() {
          _movieReviews = fetchMovieReviews(movieId: widget.movieId);
          _commentController.clear();
          rating = 0;
        });
        showToast(
          context: context,
          message: 'Avaliação enviada com sucesso!',
          type: ToastType.success,
        );
      } catch (e) {
        showToast(
          context: context,
          message: 'Ocorreu um erro! $e',
          type: ToastType.danger,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
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
            itemSize: 30,
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
                    isSubmitButtonEnabled = val.isNotEmpty;
                  });
                },
                controller: _commentController,
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
              color: isSubmitButtonEnabled
                  ? AppColors.primaryColor
                  : Colors.blueGrey,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: isSubmitButtonEnabled
                    ? () {
                        _onSubmitReview(context);
                      }
                    : null,
                borderRadius: BorderRadius.circular(50),
                splashColor: Colors.greenAccent,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      CupertinoIcons.paperplane,
                      size: 24,
                      color:
                          isSubmitButtonEnabled ? Colors.white : Colors.white38,
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
                  ...reviews.map((r) => ReviewCard(review: r)),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
