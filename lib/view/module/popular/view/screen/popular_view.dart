import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/widgets/custom_app_bar.dart';
import 'package:movie_app/utils/widgets/error_widget.dart';
import 'package:movie_app/view/module/popular/bloc/popular_movie_bloc.dart';
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

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  // void onScroll() {
  //   bool reachedExtent = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  //   if (reachedExtent && !controller.paginationLoading.value) {
  //     controller.paginationLoading.value = true;
  //     controller.pageNo++;
  //     controller.fetchTopGainerListData();
  //   }
  // }

  @override
  void initState() {
    homeBloc = BlocProvider.of<PopularMoviesBloc>(context);
    //  _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await homeBloc.getPopularMovies();
        },
        child: Scaffold(
          // backgroundColor: AppColors.primaryColor,
          appBar: customAppBar(context),
          body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PopularMoviesSuccessList) {
                debugPrint('random :: ${Random().nextInt((state.moviesData?.length ?? 0) - 0)}');
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    MainPosterWidget(size: size, recommendedMovie: state.moviesData![Random().nextInt((state.moviesData?.length ?? 0) - 0)]),
                    const SizedBox(height: 30),
                    BuildListWidget(movieList: state.moviesData ?? [], orientation: orientation),
                  ],
                );
              } else {
                return errorWidget(size, context);
              }
            },
          ),
        ),
      ),
    );
  }
}
