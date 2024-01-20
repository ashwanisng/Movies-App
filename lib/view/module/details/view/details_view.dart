import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/theme/styles.dart';
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
  var box = Hive.box('fav');

  @override
  void initState() {
    movieDetailsBloc = BlocProvider.of<MovieDetailsBloc>(context);
    movieDetailsBloc.add(SimilarMoviesEvent(widget.movieDetails.id ?? 0));

    if (box.get('movieList')?.isNotEmpty ?? false) {
      addedToFav = box.get('movieList')?.map((e) => e.id).contains(widget.movieDetails.id) ?? false;
    } else {
      addedToFav = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
                      style: Styles.h4.copyWith(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
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
                          style: Styles.h4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          widget.movieDetails.releaseDate ?? '-/-/-',
                          style: Styles.h4,
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
                              if (addedToFav) {
                                box.get('movieList').removeWhere((element) => element.id == widget.movieDetails.id);
                              } else {
                                box.get('movieList').add(widget.movieDetails);
                              }
                              box.put('movieList', box.get('movieList'));
                              addedToFav = !addedToFav;
                            });
                          },
                          icon: Icon(
                            !addedToFav ? Icons.add : Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        !addedToFav ? Text('Add to Favorite', style: Styles.h5.copyWith(fontWeight: FontWeight.w600)) : Text('Added to Favorite List', style: Styles.h5.copyWith(fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(widget.movieDetails.overview ?? '', style: Styles.h5),
                    Container(margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(
                      "Similar Movies",
                      style: Styles.h4.copyWith(fontSize: 25, fontWeight: FontWeight.w700),
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
                          return SimilarMovieLayout(
                            data: state.moviesData ?? [],
                            orientation: orientation,
                          );
                        } else {
                          debugPrint('no hello');
                          return Center(
                            child: Text("No trailer available", style: Styles.h5),
                          );
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
