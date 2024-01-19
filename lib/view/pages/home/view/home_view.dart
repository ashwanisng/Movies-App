import 'package:flutter/material.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/utils/widgets/custom_app_bar.dart';
import 'package:movie_app/view/pages/home/data/model/movie_response.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MovieRepository movieRepository = MovieRepository();

  Future<void> getPopularMovies() async {
    RepoResponse<MovieResponse> response = await movieRepository.getPopularMovies();

    if (response.data?.movie?.isNotEmpty ?? false) {
      response.data?.movie?.forEach((element) {
        debugPrint('movie name :: ${element.title}');
      });
    }
  }

  @override
  void initState() {
    getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      appBar: customAppBar(context),
      body: const Column(
        children: [
          Center(
            child: Text(''),
          )
        ],
      ),
    );
  }
}
