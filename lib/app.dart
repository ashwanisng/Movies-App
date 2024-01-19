import 'package:flutter/material.dart';
import 'package:movie_app/utils/theme/app_theme.dart';
import 'package:movie_app/utils/values/env.dart';
import 'package:movie_app/view/pages/home/view/home_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Env.title,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeView(),
    );
  }
}
