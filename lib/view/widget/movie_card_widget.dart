import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/widget/shimmer.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: Url.imageBaseUrlW400 + url,
            fit: BoxFit.fill,
            placeholder: (ctx, str) {
              return ShimmerWidget(size: MediaQuery.of(context).size, height: 200, radius: 0.0);
            },
            errorWidget: (ctx, str, dynamic) {
              return const Icon(Icons.error);
            },
          ),
          const Align(
            alignment: Alignment.center,
            child: Center(
              child: Icon(
                CupertinoIcons.play_circle,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
