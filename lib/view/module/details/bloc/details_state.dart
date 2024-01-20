import 'package:equatable/equatable.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class SimilarMoviesInitial extends DetailsState {}

class LoadingState extends DetailsState {
  const LoadingState();
}

class SimilarMoviesList extends DetailsState {
  List<MovieDetails>? moviesData;
  SimilarMoviesList({this.moviesData});
}

class SimilarMovieError extends DetailsState {
  String msg;
  SimilarMovieError({required this.msg});
}
