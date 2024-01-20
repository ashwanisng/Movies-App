import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<MovieDetails> movieList = [];
  var box = Hive.box('fav');

  @override
  void initState() {
    // movieList = (StorageUtils.getMovieData() ?? []);

    debugPrint('len is :: ${box.get('movieList')}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: box.get('movieList')?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 3 : 6, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 2 / 3),
          itemBuilder: (BuildContext context, int index) {
            return InkResponse(
              enableFeedback: true,
              child: MovieCard(url: box.get('movieList')?[index].posterPath ?? ''),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsView(movieDetails: box.get('movieList')?[index] ?? MovieDetails()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
