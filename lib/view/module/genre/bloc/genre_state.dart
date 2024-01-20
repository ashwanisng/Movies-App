import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

abstract class GenreState {
  const GenreState();
}

class GenreInitial extends GenreState {}

class LoadingState extends GenreState {
  const LoadingState();
}

class GenreDetailsSuccess extends GenreState {
  final List<MovieDetails> genreList;
  const GenreDetailsSuccess({required this.genreList});
}

class GenreDetailsError extends GenreState {
  String msg;
  GenreDetailsError({required this.msg});
}
