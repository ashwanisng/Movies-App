import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/utils/theme/app_theme.dart';
import 'package:movie_app/utils/values/env.dart';
import 'package:movie_app/view/pages/details/bloc/details_bloc.dart';
import 'package:movie_app/view/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/view/pages/home/bloc/home_event.dart';
import 'package:movie_app/view/pages/home/view/home_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _movieRepo = MovieRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(movieRepository: _movieRepo)
            ..add(
              const PopularMoviesEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => MovieDetailsBloc(movieRepository: _movieRepo),
        ),
      ],
      child: MaterialApp(
        title: Env.title,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeView(),
      ),
    );
  }
}
