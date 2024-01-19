import 'package:flutter/material.dart';
import 'package:movie_app/view/pages/details/view/details_view.dart';
import 'package:movie_app/view/pages/popular/data/model/movie_response.dart';
import 'package:movie_app/view/pages/popular/view/screen/popular_view.dart';

class BuildListWidget extends StatelessWidget {
  final List<Movie> movieList;
  final Orientation orientation;
  const BuildListWidget({super.key, required this.movieList, required this.orientation});

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
        return InkResponse(
          enableFeedback: true,
          child: MovieCard(url: movieList[index].posterPath!),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsView(
                  detail: movieList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
