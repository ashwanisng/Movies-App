import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/widgets/error_widget.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_bloc.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_event.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_state.dart';
import 'package:movie_app/view/module/popular/view/widget/build_list_widget.dart';
import 'package:movie_app/view/widget/main_psoter_widget.dart';

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({super.key});

  @override
  State<PopularMoviesView> createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  late PopularMoviesBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<PopularMoviesBloc>(context);

    homeBloc.scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    debugPrint('hhhhhhhhh');
    if (_isBottom && homeBloc.canLoadMore && !homeBloc.loadingMore) {
      homeBloc.pageNo++;
      homeBloc.add(const GetPopularMoviesEvent());
    }
  }

  bool get _isBottom {
    if (!homeBloc.scrollController.hasClients) {
      return false;
    }
    final maxScroll = homeBloc.scrollController.position.maxScrollExtent;
    final currentScroll = homeBloc.scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }

  @override
  void dispose() {
    homeBloc.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          bloc: homeBloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PopularMoviesSuccessList) {
              return ListView(
                controller: homeBloc.scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  MainPosterWidget(size: size, recommendedMovie: state.moviesData![Random().nextInt((state.moviesData?.length ?? 0) - 0)]),
                  const SizedBox(height: 30),
                  BuildListWidget(
                    movieList: state.moviesData ?? [],
                    orientation: orientation,
                    loadMore: homeBloc.loadingMore,
                  ),
                ],
              );
            } else {
              return errorWidget(size, context);
            }
          },
        ),
      ),
    );
  }
}
