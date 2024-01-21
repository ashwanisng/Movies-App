import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/theme/styles.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  var box = Hive.box('fav');
  late List data;

  @override
  void initState() {
    data = box.get('movieList') ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Styles.h4,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: data.isEmpty
          ? Center(
              child: Text(
                'No Result Found!',
                style: Styles.h4,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: data.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 2 / 3),
                itemBuilder: (BuildContext context, int index) {
                  return InkResponse(
                    enableFeedback: true,
                    child: MovieCard(url: data[index].posterPath ?? ''),
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => DetailsView(
                              movieDetails: data[index] ?? MovieDetails()),
                        ),
                      )
                          .then(
                        (value) {
                          data = box.get('movieList');
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
