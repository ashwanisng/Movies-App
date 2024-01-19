import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/utils/widgets/custom_app_bar.dart';
import 'package:movie_app/utils/widgets/error_widget.dart';
import 'package:movie_app/view/pages/details/view/details_view.dart';
import 'package:movie_app/view/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/view/pages/home/bloc/home_state.dart';
import 'package:movie_app/view/pages/home/data/model/movie_response.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
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
          body: BlocBuilder<HomeBloc, HomeState>(
            // bloc: latestMovieBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LatestMoviesList) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    suggestMovie(size, state.moviesData![0], context),
                    const SizedBox(height: 30),
                    buildList(movieList: state.moviesData, orientation: orientation),
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

Widget suggestMovie(Size size, Movie recommendedMovie, BuildContext context) {
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: CachedNetworkImage(
            cacheKey: 'main',
            imageUrl: Url.imageBaseUrlW400 + recommendedMovie.posterPath!,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 30,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black, spreadRadius: 40, blurRadius: 30),
            ]),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
                  Text(
                    recommendedMovie.voteAverage!.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: Theme.of(context).textTheme.displayMedium,
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                  Text(
                    'Info',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildList({required List<Movie>? movieList, required Orientation orientation}) {
  return GridView.builder(
    itemCount: movieList?.length,
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
        child: MovieCard(url: movieList![index].posterPath!),
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
