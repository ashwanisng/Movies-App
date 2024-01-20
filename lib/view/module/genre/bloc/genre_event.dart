abstract class GenreEvent {
  const GenreEvent();
}

class GetGenreEvent extends GenreEvent {
  final String genreId;
  const GetGenreEvent({required this.genreId});
}
