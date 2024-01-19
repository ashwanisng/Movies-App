import 'package:equatable/equatable.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class GetGenreEvent extends GenreEvent {
  final String genreId;
  const GetGenreEvent({required this.genreId});
}
