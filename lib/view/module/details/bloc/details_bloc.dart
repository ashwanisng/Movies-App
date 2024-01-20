import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/details/bloc/details_event.dart';
import 'package:movie_app/view/module/details/bloc/details_state.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class MovieDetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final MovieRepository _movieRepository;
  final scrollController = ScrollController();
  int pageNo = 1;
  bool canLoadMore = true, loadingMore = false;
  List<MovieDetails> movieDetailsList = [];

  MovieDetailsBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(SimilarMoviesInitial()) {
    on<SimilarMoviesEvent>(_mapGetSimilarMovies);
  }

  _mapGetSimilarMovies(SimilarMoviesEvent event, Emitter<DetailsState> emit) async {
    emit(const LoadingState());
    if (movieDetailsList.isEmpty) {
      pageNo = 1;
      movieDetailsList.clear();
      canLoadMore = true;
      loadingMore = false;
      emit(const LoadingState());
    } else {
      canLoadMore = true;
      loadingMore = true;
      emit(SimilarMoviesList(moviesData: movieDetailsList));
    }
    try {
      RepoResponse<MovieResponse> movieResponse = await _movieRepository.getSimilarMovies(event.movieId, pageNo);

      if (movieResponse.data != null) {
        movieDetailsList = [...movieDetailsList, ...movieResponse.data?.movieDetails ?? []];
        canLoadMore = pageNo < (movieResponse.data?.totalPages ?? 1);
        loadingMore = false;
        emit(SimilarMoviesList(moviesData: movieDetailsList));
      } else {
        emit(SimilarMovieError(msg: movieResponse.error?.message ?? ''));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
