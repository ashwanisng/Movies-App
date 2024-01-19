import 'package:flutter/material.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/view/pages/favorites/view/screen/favorites_view.dart';
import 'package:movie_app/view/pages/popular/view/screen/popular_view.dart';
import 'package:movie_app/view/pages/search/screen/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PopularMoviesView(),
    SearchView(),
    FavoritesView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Poplular',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: AppColors.primaryColor,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        unselectedFontSize: 14,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
