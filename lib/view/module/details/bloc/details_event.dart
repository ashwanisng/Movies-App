import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class SimilarMoviesEvent extends DetailsEvent {
  final int movieId;
  const SimilarMoviesEvent(this.movieId);
}
