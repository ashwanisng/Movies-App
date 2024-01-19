import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/genre/bloc/genre_bloc.dart';
import 'package:movie_app/view/module/genre/bloc/genre_event.dart';
import 'package:movie_app/view/module/genre/bloc/genre_state.dart';
import 'package:movie_app/view/module/popular/view/screen/popular_view.dart';
import 'package:movie_app/view/module/search/data/model/genre.dart';

class GenreView extends StatefulWidget {
  final Genres genreDetails;
  const GenreView({super.key, required this.genreDetails});

  @override
  State<GenreView> createState() => _GenreViewState();
}

class _GenreViewState extends State<GenreView> {
  late GenreBloc genreBloc;

  @override
  void initState() {
    genreBloc = BlocProvider.of<GenreBloc>(context);
    genreBloc.add(GetGenreEvent(genreId: widget.genreDetails.id ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genreDetails.name ?? ""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GenreBloc, GenreState>(
          bloc: genreBloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GenreDetailsSuccess) {
              debugPrint('hello :: ${state.genreList.length}');
              var data = state.genreList;
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
                  return GestureDetector(
                    child: MovieCard(url: data[index].posterPath ?? ''),
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsView(
                            title: data[index].title ?? '',
                            movieId: data[index].id ?? 0,
                            releaseDate: data[index].releaseDate ?? '',
                            voteAverage: data[index].voteAverage ?? 0,
                            posterPath: data[index].posterPath ?? '',
                            overview: data[index].overview ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              debugPrint('no hello');
              return noTrailer();
            }
          },
        ),
      ),
    );
  }
}
