abstract class DetailsEvent {
  const DetailsEvent();
}

class SimilarMoviesEvent extends DetailsEvent {
  final int movieId;
  const SimilarMoviesEvent(this.movieId);
}
