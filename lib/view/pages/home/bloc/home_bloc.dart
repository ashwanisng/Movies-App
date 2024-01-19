import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/view/pages/home/bloc/home_event.dart';
import 'package:movie_app/view/pages/home/bloc/home_state.dart';
import 'package:movie_app/view/pages/home/data/model/movie_response.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository _movieRepository;
  HomeBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(PopularMovieInitial()) {
    on<PopularMoviesEvent>(_mapGetMoviesFeed);
  }

  _mapGetMoviesFeed(PopularMoviesEvent event, Emitter<HomeState> emit) async {
    emit(const LoadingState());
    try {
      List<Movie>? data = await getPopularMovies();

      emit(LatestMoviesList(moviesData: data));
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
