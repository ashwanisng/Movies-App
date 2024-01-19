import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/module/search/data/model/genre.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final genres = GenresList.fromJson(genreslist).list;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Search",
                // style: heading.copyWith(color: Colors.cyanAccent, fontSize: 36),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                keyboardType: TextInputType.text,
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
                  hintStyle: TextStyle(
                    letterSpacing: .0,
                    color: Colors.white.withOpacity(.7),
                  ),
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
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    // pushNewScreen(
                    //     context,
                    //     BlocProvider(
                    //       create: (context) => SearchResultsCubit()..init(query),
                    //       child: SearchResults(query: query),
                    //     ));
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Popular Genres",
                // style: heading.copyWith(
                //   color: Colors.white,
                //   fontSize: 16,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 28 / 16),
                children: [
                  for (var i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GenreTile(
                        genre: genres[i],
                      ),
                    )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Browes all",
                // style: heading.copyWith(
                //   color: Colors.white,
                //   fontSize: 16,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 28 / 16),
                children: [
                  for (var i = 4; i < genres.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GenreTile(
                        genre: genres[i],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenreTile extends StatelessWidget {
  final Genres genre;
  const GenreTile({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          // pushNewScreen(
          //     context,
          //     BlocProvider(
          //       create: (context) => GenreResultsCubit()..init(genre.id),
          //       child: GenreResults(query: genre.name),
          //     ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: genre.color,
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: -5,
                  right: -20,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(380 / 360),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: genre.image ?? '',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 75,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Text(
                    genre.name ?? '',
                    // style: normalText.copyWith(
                    //   fontWeight: FontWeight.w700,
                    //   color: Colors.white,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
