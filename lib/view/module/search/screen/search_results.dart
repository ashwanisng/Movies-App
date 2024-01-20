import 'package:flutter/material.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/search/data/model/genre_response.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class SearchResults extends StatefulWidget {
  final List<GenreDetails>? searchResultList;

  const SearchResults({super.key, this.searchResultList});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
            child: Text(
              'Top Results',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          GridView.builder(
            itemCount: widget.searchResultList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 3 : 6, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 2 / 3),
            itemBuilder: (BuildContext context, int index) {
              var data = widget.searchResultList?[index];
              return InkResponse(
                enableFeedback: true,
                child: MovieCard(url: widget.searchResultList?[index].posterPath ?? ''),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsView(
                      movieId: data?.id ?? 0,
                      title: data?.title ?? '',
                      releaseDate: data?.releaseDate ?? '',
                      voteAverage: data?.voteAverage ?? 0,
                      posterPath: data?.posterPath ?? '',
                      overview: data?.overview ?? '',
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}