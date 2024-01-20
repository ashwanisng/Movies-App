import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class PopularMoviesState {
  const PopularMoviesState();
}

class PopularMovieInitial extends PopularMoviesState {}

class LoadingState extends PopularMoviesState {
  const LoadingState();
}

class PopularMoviesSuccessList extends PopularMoviesState {
  List<MovieDetails>? moviesData;
  PopularMoviesSuccessList({this.moviesData});
}

class PopularMoviesError extends PopularMoviesState {
  String msg;
  PopularMoviesError({required this.msg});
}
