import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_event.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_state.dart';

class PopularMoviesBloc extends Bloc<PopularMovieEvent, PopularMoviesState> {
  final MovieRepository _movieRepository;
  PopularMoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(PopularMovieInitial()) {
    on<GetPopularMoviesEvent>(_mapGetMoviesFeed);
  }

  _mapGetMoviesFeed(GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    emit(const LoadingState());
    try {
      List<Movie>? data = await getPopularMovies();

      emit(PopularMoviesSuccessList(moviesData: data));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getPopularMovies() async {
    RepoResponse<MovieResponse> response = await _movieRepository.getPopularMovies();

    if (response.data?.movie?.isNotEmpty ?? false) {
      return response.data?.movie;
    }
  }
}
