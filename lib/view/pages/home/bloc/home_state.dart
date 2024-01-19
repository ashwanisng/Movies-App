import 'package:equatable/equatable.dart';
import 'package:movie_app/view/pages/home/data/model/movie_response.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends HomeState {}

class LoadingState extends HomeState {
  const LoadingState();
}

class LatestMoviesList extends HomeState {
  List<Movie>? moviesData;
  LatestMoviesList({
    this.moviesData,
  });
}
