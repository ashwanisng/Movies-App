import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/utils/widgets/custom_app_bar.dart';
import 'package:movie_app/utils/widgets/error_widget.dart';
import 'package:movie_app/utils/widgets/similar_movies_widget.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_bloc.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_state.dart';
import 'package:movie_app/view/module/popular/view/widget/build_list_widget.dart';

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({super.key});

  @override
  State<PopularMoviesView> createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  late PopularMoviesBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<PopularMoviesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await homeBloc.getPopularMovies();
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: customAppBar(context),
          body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PopularMoviesSuccessList) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SimilarMoviesWidget(size: size, recommendedMovie: state.moviesData![0]),
                    const SizedBox(height: 30),
                    BuildListWidget(movieList: state.moviesData ?? [], orientation: orientation),
                  ],
                );
              } else {
                return errorWidget(size, context);
              }
            },
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: Url.imageBaseUrlW400 + url,
            fit: BoxFit.fill,
          ),
          const Align(
            alignment: Alignment.center,
            child: Center(
              child: Icon(
                CupertinoIcons.play_circle,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
