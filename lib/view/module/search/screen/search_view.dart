import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/helper/debounce.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/genre/screen/genre_view.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/module/search/bloc/search_bloc.dart';
import 'package:movie_app/view/module/search/bloc/search_event.dart';
import 'package:movie_app/view/module/search/bloc/search_state.dart';
import 'package:movie_app/view/module/search/data/model/genre.dart';
import 'package:movie_app/view/module/search/screen/search_results.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();
  final genres = GenresList.fromJson(genreslist).list;
  late SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    searchMovieBloc = BlocProvider.of<SearchMovieBloc>(context);
    // searchMovieBloc.add(LoadSearchEvent(query: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Search",
                // style: heading.copyWith(color: Colors.cyanAccent, fontSize: 36),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: "Search movies,tv shows or cast...",
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  hintStyle: TextStyle(
                    letterSpacing: .0,
                    color: Colors.white.withOpacity(.7),
                  ),
                  fillColor: Colors.white.withOpacity(.1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: .2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: .2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: .2,
                    ),
                  ),
                ),
                // onChanged: (String value) {
                //   EasyDebounce.debounce(
                //     'search',
                //     const Duration(milliseconds: 300),
                //     () {
                //       searchMovieBloc.add(LoadSearchEvent(query: value));
                //     },
                //   );
                // },

                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    EasyDebounce.debounce(
                      'search',
                      const Duration(milliseconds: 300),
                      () {
                        searchMovieBloc.add(LoadSearchEvent(query: value));
                      },
                    );
                  }
                },

                controller: searchController,
              ),
            ),
            BlocListener<SearchMovieBloc, SearchMovieState>(
              bloc: searchMovieBloc,
              listener: (context, state) {
                if (state is SearchSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchResults(searchResultList: state.moviesData)),
                  );
                }
              },
              child: Container(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Popular Genres",
                // style: heading.copyWith(
                //   color: Colors.white,
                //   fontSize: 16,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 28 / 16),
                children: [
                  for (var i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GenreTile(
                        genre: genres[i],
                      ),
                    )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Browes all",
                // style: heading.copyWith(
                //   color: Colors.white,
                //   fontSize: 16,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 28 / 16),
                children: [
                  for (var i = 4; i < genres.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GenreTile(
                        genre: genres[i],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResult({required List<MovieDetails> searchList, required Orientation orientation}) {
    return ListView(
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
          itemCount: searchList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 3 : 6, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 2 / 3),
          itemBuilder: (BuildContext context, int index) {
            var data = searchList[index];
            return InkResponse(
              enableFeedback: true,
              child: MovieCard(url: searchList[index].posterPath ?? ''),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsView(
                    movieId: data.id ?? 0,
                    title: data.title ?? '',
                    releaseDate: data.releaseDate ?? '',
                    voteAverage: data.voteAverage ?? 0,
                    posterPath: data.posterPath ?? '',
                    overview: data.overview ?? '',
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class GenreTile extends StatelessWidget {
  final Genres genre;
  const GenreTile({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GenreView(genreDetails: genre),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: genre.color,
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: -5,
                  right: -20,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(380 / 360),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: genre.image ?? '',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 75,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Text(
                    genre.name ?? '',
                    // style: normalText.copyWith(
                    //   fontWeight: FontWeight.w700,
                    //   color: Colors.white,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
