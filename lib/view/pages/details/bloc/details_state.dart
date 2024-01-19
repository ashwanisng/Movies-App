import 'package:equatable/equatable.dart';
import 'package:movie_app/view/pages/details/data/model/similar_movie_response.dart';
import 'package:movie_app/view/pages/home/data/model/movie_response.dart';

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
  List<SimilarMovies>? moviesData;
  SimilarMoviesList({
    this.moviesData,
  });
}
