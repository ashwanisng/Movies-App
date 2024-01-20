import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/genre/bloc/genre_event.dart';
import 'package:movie_app/view/module/genre/bloc/genre_state.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final SearchRepository _searchRepository;
  GenreBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(GenreInitial()) {
    on<GetGenreEvent>(_mapGetMovieByGenre);
  }

  _mapGetMovieByGenre(GetGenreEvent event, Emitter<GenreState> emit) async {
    emit(const LoadingState());
    try {
      debugPrint("movie id is ${event.genreId}");
      RepoResponse<MovieResponse> data = await _searchRepository.getMovieByGenre(event.genreId);

      emit(GenreDetailsSuccess(genreList: data.data?.movieDetails ?? []));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
