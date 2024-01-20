import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/repository/search_repository.dart';
import 'package:movie_app/utils/helper/debounce.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/theme/styles.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:movie_app/view/module/search/bloc/search_bloc.dart';
import 'package:movie_app/view/module/search/bloc/search_event.dart';
import 'package:movie_app/view/module/search/bloc/search_state.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class SearchResults extends StatefulWidget {
  final List<MovieDetails> searchResultList;

  const SearchResults({super.key, required this.searchResultList});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  SearchMovieBloc searchMovieBloc = SearchMovieBloc(searchRepository: SearchRepository());

  void _onScroll() {
    if (_isBottom && searchMovieBloc.canLoadMore && !searchMovieBloc.loadingMore) {
      searchMovieBloc.pageNo++;
      searchMovieBloc.add(LoadSearchEvent());
    }
  }

  @override
  void initState() {
    searchMovieBloc.scrollController.addListener(_onScroll);
    super.initState();
  }

  bool get _isBottom {
    if (!searchMovieBloc.scrollController.hasClients) {
      return false;
    }
    final maxScroll = searchMovieBloc.scrollController.position.maxScrollExtent;
    final currentScroll = searchMovieBloc.scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }

  @override
  void dispose() {
    searchMovieBloc.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        controller: searchMovieBloc.scrollController,
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SearchResults(searchResultList: [])),
                    );
                  },
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  autofocus: true,
                  style: Styles.h4,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: "Search movies,tv shows or cast...",
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    hintStyle: Styles.h5,
                    fillColor: Colors.white.withOpacity(.1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    EasyDebounce.debounce(
                      'search',
                      const Duration(milliseconds: 300),
                      () {
                        searchMovieBloc.movieDetailsList.clear();
                        searchMovieBloc.pageNo = 1;
                        searchMovieBloc.add(LoadSearchEvent());
                      },
                    );
                  },
                  controller: searchMovieBloc.searchController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
                child: Text(
                  'Top Results',
                  style: Styles.h4.copyWith(color: Colors.white),
                ),
              ),
              BlocBuilder(
                bloc: searchMovieBloc,
                buildWhen: (previous, current) => current is SearchSuccess || current is SearchLoading || current is SearchError,
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    if (state.moviesData?.isEmpty ?? false) {
                      return const Center(child: Text('No result found!'));
                    } else {
                      return GridView.builder(
                        itemCount: (state.moviesData!.length + 1) ?? 0,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 2 / 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index >= (state.moviesData?.length ?? 1)) {
                            return Visibility(
                              visible: searchMovieBloc.loadingMore,
                              child: Transform.scale(
                                scale: 0.5,
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                            );
                          } else {
                            return InkResponse(
                              enableFeedback: true,
                              child: MovieCard(url: state.moviesData?[index].posterPath ?? ''),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailsView(movieDetails: state.moviesData?[index] ?? MovieDetails()),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  }
                  if (state is SearchError) {
                    return Text(state.msg.toString());
                  }
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
