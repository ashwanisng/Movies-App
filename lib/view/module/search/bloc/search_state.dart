import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class SearchMovieState  {
  const SearchMovieState();

}

class SearchMovieInitial extends SearchMovieState {
  final bool firstTime;
  const SearchMovieInitial({this.firstTime = false});
}

class SearchLoading extends SearchMovieState {}

class SearchSuccess extends SearchMovieState {
  List<MovieDetails>? moviesData;
  SearchSuccess({this.moviesData});
}

class SearchError extends SearchMovieState {
  String msg;
  SearchError({required this.msg});
}
