import 'package:equatable/equatable.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/module/search/data/model/genre_response.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchLoading extends SearchMovieState {}

class SearchSuccess extends SearchMovieState {
  List<GenreDetails>? moviesData;
  SearchSuccess({
    this.moviesData,
  });
}

class SearchError extends SearchMovieState {}
