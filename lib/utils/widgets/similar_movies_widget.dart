import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/pages/popular/data/model/movie_response.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final Size size;
  final Movie recommendedMovie;
  const SimilarMoviesWidget({super.key, required this.size, required this.recommendedMovie});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: CachedNetworkImage(
              cacheKey: 'main',
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
                      style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.displayMedium,
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    ),
                    Text(
                      'Info',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
