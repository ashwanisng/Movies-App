import 'package:flutter/material.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class BuildListWidget extends StatelessWidget {
  final List<MovieDetails> movieList;
  final Orientation orientation;
  final bool loadMore;
  const BuildListWidget({super.key, required this.movieList, required this.orientation, required this.loadMore});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index >= (movieList.length ?? 1)) {
          return Visibility(
            visible: loadMore,
            child: Transform.scale(
              scale: 0.5,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return InkResponse(
            enableFeedback: true,
            child: MovieCard(url: movieList[index].posterPath!),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsView(movieDetails: movieList[index]),
                ),
              );
            },
          );
        }
      },
    );
  }
}
