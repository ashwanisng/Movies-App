import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchEvent extends SearchMovieEvent {
  String query;
  LoadSearchEvent({required this.query});
}
