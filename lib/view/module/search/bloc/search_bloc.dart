import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/search/bloc/search_event.dart';
import 'package:movie_app/view/module/search/bloc/search_state.dart';
import 'package:movie_app/view/module/search/data/model/genre_response.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchRepository _searchRepository;
  SearchMovieBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(SearchMovieInitial()) {
    on<LoadSearchEvent>(_mapSearchMovies);
  }

  _mapSearchMovies(LoadSearchEvent event, Emitter<SearchMovieState> emit) async {
    emit(SearchLoading());
    try {
      RepoResponse<GenreResponse> data = await _searchRepository.searchMovies(event.query);
      emit(SearchSuccess(moviesData: data.data?.genreDetails ?? []));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
