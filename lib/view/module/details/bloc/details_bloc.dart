import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/details/bloc/details_event.dart';
import 'package:movie_app/view/module/details/bloc/details_state.dart';
import 'package:movie_app/view/module/details/data/model/similar_movie_response.dart';

class MovieDetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final MovieRepository _movieRepository;
  MovieDetailsBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(SimilarMoviesInitial()) {
    on<SimilarMoviesEvent>(_mapGetSimilarMovies);
  }

  _mapGetSimilarMovies(SimilarMoviesEvent event, Emitter<DetailsState> emit) async {
    emit(const LoadingState());
    try {
      RepoResponse<SimilarMovieResponse> movieResponse = await _movieRepository.getSimilarMovies(event.movieId);

      if (movieResponse.data != null) {
        emit(SimilarMoviesList(moviesData: movieResponse.data?.similarMovies));
      } else {
        emit(SimilarMovieError(msg: movieResponse.error?.message ?? ""));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
