import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/details/bloc/details_bloc.dart';
import 'package:movie_app/view/module/details/bloc/details_event.dart';
import 'package:movie_app/view/module/details/bloc/details_state.dart';
import 'package:movie_app/view/module/details/data/model/similar_movie_response.dart';
import 'package:movie_app/view/module/popular/view/screen/popular_view.dart';

class DetailsView extends StatefulWidget {
  final int movieId;
  final String title;
  final String releaseDate;
  final String posterPath;
  final String overview;
  final num voteAverage;

  const DetailsView({super.key, required this.movieId, required this.title, required this.releaseDate, required this.voteAverage, required this.posterPath, required this.overview});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late MovieDetailsBloc movieDetailsBloc;

  @override
  void initState() {
    movieDetailsBloc = BlocProvider.of<MovieDetailsBloc>(context);
    movieDetailsBloc.add(SimilarMoviesEvent(widget.movieId ?? 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primaryColor,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                  imageUrl: Url.imageBaseUrlW500 + (widget.posterPath ?? ''),
                  placeholder: (ctx, str) {
                    return Container();
                  },
                  errorWidget: (ctx, str, dynamic) {
                    return const Icon(Icons.error);
                  },
                  fit: BoxFit.fill,
                )),
              ),
            ];
          },
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(margin: const EdgeInsets.only(top: 5.0)),
                    Text(
                      widget.title ?? 'Movie',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          widget.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          widget.releaseDate ?? '-/-/-',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(widget.overview),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    const Text(
                      "Trailer",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    BlocBuilder<MovieDetailsBloc, DetailsState>(
                      bloc: movieDetailsBloc,
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SimilarMoviesList) {
                          debugPrint('hello :: ${state.moviesData?.length}');
                          return trailerLayout(data: state.moviesData ?? [], orientation: orientation);
                        } else {
                          debugPrint('no hello');
                          return noTrailer();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget trailerLayout({
  required List<SimilarMovies> data,
  required Orientation orientation,
}) {
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

trailerItem({
  required String title,
  required String posterPath,
}) {
  debugPrint('name :: $title');
  return Column(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: MovieCard(url: posterPath),
        ),
      ),
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget noTrailer() {
  return const Center(
    child: Text("No trailer available"),
  );
}
