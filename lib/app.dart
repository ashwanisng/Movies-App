import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/utils/theme/app_theme.dart';
import 'package:movie_app/utils/values/env.dart';
import 'package:movie_app/view/module/details/bloc/details_bloc.dart';
import 'package:movie_app/view/module/genre/bloc/genre_bloc.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_bloc.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_event.dart';
import 'package:movie_app/view/module/search/bloc/search_bloc.dart';
import 'package:movie_app/view/module/splash/splash_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _movieRepo = MovieRepository();
  final _searchRepo = SearchRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PopularMoviesBloc(movieRepository: _movieRepo)..add(const GetPopularMoviesEvent())),
        BlocProvider(create: (context) => MovieDetailsBloc(movieRepository: _movieRepo)),
        BlocProvider(create: (context) => SearchMovieBloc(searchRepository: _searchRepo)),
        BlocProvider(create: (context) => GenreBloc(searchRepository: _searchRepo)),
      ],
      child: MaterialApp(
        title: Env.title,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashView(),
      ),
    );
  }
}
