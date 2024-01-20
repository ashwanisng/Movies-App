import 'package:equatable/equatable.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}

class LoadingState extends GenreState {
  const LoadingState();
}

class GenreDetailsSuccess extends GenreState {
  final List<MovieDetails> genreList;
  const GenreDetailsSuccess({required this.genreList});
}
