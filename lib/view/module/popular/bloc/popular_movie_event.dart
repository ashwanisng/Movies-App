import 'package:equatable/equatable.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends PopularMovieEvent {
  const GetPopularMoviesEvent();
}
