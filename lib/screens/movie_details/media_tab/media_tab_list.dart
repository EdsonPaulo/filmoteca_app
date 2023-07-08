// ignore_for_file: use_build_context_synchronously

import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:filmoteca_app/utils/app_toasts.dart';

class MediaTabList extends StatelessWidget {
  final List<MovieTrailerModel> moviesImgList;
  final List<MovieTrailerModel> moviesVidList;

  const MediaTabList({
    super.key,
    required this.moviesImgList,
    required this.moviesVidList,
  });

  void _launchURL(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showToast(
          context: context,
          message: 'Não foi possível abrir o URL: $url',
          type: ToastType.danger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moviesImgList.length < moviesVidList.length
          ? moviesImgList.length
          : moviesVidList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemBuilder: (BuildContext context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  final videoUrl = Uri(
                    scheme: 'https',
                    host: 'youtube.com',
                    path: '/watch',
                    queryParameters: {'v': moviesVidList[index].videoKey},
                  );

                  _launchURL(videoUrl, context);
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
              const SizedBox(width: 10),
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
    );
  }
}
