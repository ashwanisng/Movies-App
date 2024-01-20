import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_event.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_state.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class PopularMoviesBloc extends Bloc<PopularMovieEvent, PopularMoviesState> {
  final MovieRepository _movieRepository;
  final scrollController = ScrollController();
  int pageNo = 1;
  bool canLoadMore = true, loadingMore = false;
  List<MovieDetails> movieDetailsList = [];

  PopularMoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(PopularMovieInitial()) {
    on<GetPopularMoviesEvent>(_mapGetMoviesFeed);
  }

  _mapGetMoviesFeed(GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    if (movieDetailsList.isEmpty) {
      pageNo = 1;
      movieDetailsList.clear();
      canLoadMore = true;
      loadingMore = false;
      emit(const LoadingState());
    } else {
      canLoadMore = true;
      loadingMore = true;
      emit(PopularMoviesSuccessList(moviesData: movieDetailsList));
    }
    try {
      RepoResponse<MovieResponse> movieResponse = await _movieRepository.getPopularMovies(pageNo);
      if (movieResponse.data != null) {
        movieDetailsList = [...movieDetailsList, ...movieResponse.data?.movieDetails ?? []];
        canLoadMore = pageNo < (movieResponse.data?.totalPages ?? 1);
        loadingMore = false;
        debugPrint('len is :: ${movieDetailsList.length}');
        emit(PopularMoviesSuccessList(moviesData: movieDetailsList));
      } else {
        emit(PopularMoviesError(msg: movieResponse.error?.message ?? ''));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
