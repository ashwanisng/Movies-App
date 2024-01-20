import 'package:equatable/equatable.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMoviesState {}

class LoadingState extends PopularMoviesState {
  const LoadingState();
}

class PopularMoviesSuccessList extends PopularMoviesState {
  List<MovieDetails>? moviesData;
  PopularMoviesSuccessList({this.moviesData});
}
