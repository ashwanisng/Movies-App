import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/module/search/bloc/search_event.dart';
import 'package:movie_app/view/module/search/bloc/search_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchRepository _searchRepository;
  final scrollController = ScrollController();
  int pageNo = 1;
  bool canLoadMore = true, loadingMore = false;

  List<MovieDetails> movieDetailsList = [];

  final searchController = TextEditingController();

  SearchMovieBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(const SearchMovieInitial()) {
    on<LoadSearchEvent>(_mapSearchMovies);
  }

  _mapSearchMovies(LoadSearchEvent event, Emitter<SearchMovieState> emit) async {
    if (movieDetailsList.isEmpty) {
      pageNo = 1;
      movieDetailsList.clear();
      canLoadMore = true;
      loadingMore = false;
      emit(SearchLoading());
    } else {
      canLoadMore = true;
      loadingMore = true;
      emit(SearchSuccess(moviesData: movieDetailsList));
    }
    try {
      RepoResponse<MovieResponse> movieResponse = await _searchRepository.searchMovies(
        searchController.text,
        pageNo,
      );

      if (movieResponse.data != null) {
        movieDetailsList = [...movieDetailsList, ...movieResponse.data?.movieDetails ?? []];
        canLoadMore = pageNo < (movieResponse.data?.totalPages ?? 1);
        loadingMore = false;
        debugPrint('len is :: ${movieDetailsList.length}');
        emit(SearchSuccess(moviesData: movieDetailsList));
      } else {
        emit(SearchError(msg: movieResponse.error?.message ?? ''));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
