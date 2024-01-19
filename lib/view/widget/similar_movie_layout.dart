import 'package:flutter/material.dart';
import 'package:movie_app/view/module/details/data/model/similar_movie_response.dart';
import 'package:movie_app/view/module/popular/view/screen/popular_view.dart';

class SimilarMovieLayout extends StatelessWidget {
  final List<SimilarMovies> data;
  final Orientation orientation;
  const SimilarMovieLayout({super.key, required this.data, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(url: data[index].posterPath ?? '');
      },
    );
  }
}
