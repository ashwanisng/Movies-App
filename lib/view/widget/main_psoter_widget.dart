import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/theme/styles.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class MainPosterWidget extends StatelessWidget {
  final Size size;
  final MovieDetails recommendedMovie;
  final VoidCallback onTap;
  const MainPosterWidget({super.key, required this.size, required this.recommendedMovie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: CachedNetworkImage(
                cacheKey: recommendedMovie.posterPath! + DateTime.now().day.toString(),
                imageUrl: Url.imageBaseUrlW400 + recommendedMovie.posterPath!,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 40, blurRadius: 30),
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                      Text(
                        recommendedMovie.voteAverage!.toStringAsFixed(1),
                        style: Styles.h4.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: Theme.of(context).textTheme.displayMedium,
                    ),
                    child: Text(
                      'Play',
                      style: Styles.h4.copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                      ),
                      Text(
                        'Info',
                        style: Styles.h4.copyWith(color: Colors.grey),
                      ),
                    ],
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
