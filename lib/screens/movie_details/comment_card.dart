import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  _CommentCard createState() => _CommentCard();
}

class _CommentCard extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            child: Text(''),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Estefan Bridge',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      const Text(
        'Lorem ipsum dolor sitiusu amet consectetur. Urna sagittis aliquam eget morbi arcu varius aliquam enim placerat.',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      Row(
        children: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.heart,
              color: AppColors.primaryColor,
            ),
            onPressed: () {},
          ),
          const Text(
            '173',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 250,
          ),
          const Text(
            '2 dias atrás',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
    ]);
  }
}
