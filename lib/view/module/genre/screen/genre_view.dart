import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/utils/theme/styles.dart';
import 'package:movie_app/view/module/details/view/details_view.dart';
import 'package:movie_app/view/module/genre/bloc/genre_bloc.dart';
import 'package:movie_app/view/module/genre/bloc/genre_event.dart';
import 'package:movie_app/view/module/genre/bloc/genre_state.dart';
import 'package:movie_app/view/module/search/data/model/genre.dart';
import 'package:movie_app/view/widget/movie_card_widget.dart';

class GenreView extends StatefulWidget {
  final Genres genreDetails;
  const GenreView({super.key, required this.genreDetails});

  @override
  State<GenreView> createState() => _GenreViewState();
}

class _GenreViewState extends State<GenreView> {
  late GenreBloc genreBloc;

  @override
  void initState() {
    genreBloc = BlocProvider.of<GenreBloc>(context);
    genreBloc.add(GetGenreEvent(genreId: widget.genreDetails.id ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(widget.genreDetails.name ?? "", style: Styles.h4),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GenreBloc, GenreState>(
          bloc: genreBloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GenreDetailsSuccess) {
              var data = state.genreList;
              return GridView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MovieCard(url: data[index].posterPath ?? ''),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsView(movieDetails: data[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("No trailer available"));
            }
          },
        ),
      ),
    );
  }
}
