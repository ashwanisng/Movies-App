import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/storage_utils.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/details/bloc/details_bloc.dart';
import 'package:movie_app/view/module/details/bloc/details_event.dart';
import 'package:movie_app/view/module/details/bloc/details_state.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/widget/similar_movie_layout.dart';

class DetailsView extends StatefulWidget {
  final MovieDetails movieDetails;

  const DetailsView({super.key, required this.movieDetails});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late MovieDetailsBloc movieDetailsBloc;
  late bool addedToFav;

  @override
  void initState() {
    movieDetailsBloc = BlocProvider.of<MovieDetailsBloc>(context);
    movieDetailsBloc.add(SimilarMoviesEvent(widget.movieDetails.id ?? 0));
    MovieDetails? data = StorageUtils.getMovieData();
    addedToFav = data?.fav ?? false;
    debugPrint('true hai kya?? ${data?.fav}');
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
                  imageUrl: Url.imageBaseUrlW500 + (widget.movieDetails.posterPath ?? ''),
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
                      widget.movieDetails.title ?? 'Movie',
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
                          widget.movieDetails.voteAverage?.toStringAsFixed(1) ?? '',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          widget.movieDetails.releaseDate ?? '-/-/-',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              addedToFav = !addedToFav;

                              widget.movieDetails.fav = addedToFav;

                              if (addedToFav) {
                                StorageUtils.setMovieData(widget.movieDetails);
                              } else {
                                StorageUtils.remove('movieData');
                              }
                            });
                          },
                          icon: Icon(!addedToFav ? Icons.add : Icons.check),
                        ),
                        !addedToFav ? const Text('Add to Favorite') : const Text('Added to Favorite List')
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(widget.movieDetails.overview ?? ''),
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
                          return SimilarMovieLayout(
                            data: state.moviesData ?? [],
                            orientation: orientation,
                          );
                        } else {
                          debugPrint('no hello');
                          return const Center(child: Text("No trailer available"));
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
