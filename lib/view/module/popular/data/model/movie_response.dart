import 'package:hive/hive.dart';

part 'movie_response.g.dart';

@HiveType(typeId: 0)
class MovieResponse {
  @HiveField(0)
  int? page;
  @HiveField(1)
  List<MovieDetails>? movieDetails;
  @HiveField(2)
  int? totalPages;
  @HiveField(3)
  int? totalResults;

  MovieResponse({this.page, this.movieDetails, this.totalPages, this.totalResults});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieDetails = <MovieDetails>[];
      json['results'].forEach((v) {
        movieDetails!.add(MovieDetails.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (movieDetails != null) {
      data['results'] = movieDetails!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

@HiveType(typeId: 1)
class MovieDetails {
  @HiveField(0)
  bool? adult;
  @HiveField(1)
  String? backdropPath;
  @HiveField(2)
  List<int>? genreIds;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? originalLanguage;
  @HiveField(5)
  String? originalTitle;
  @HiveField(6)
  String? overview;
  @HiveField(7)
  num? popularity;
  @HiveField(8)
  String? posterPath;
  @HiveField(9)
  String? releaseDate;
  @HiveField(10)
  String? title;
  @HiveField(11)
  bool? video;
  @HiveField(12)
  num? voteAverage;
  @HiveField(13)
  int? voteCount;
  @HiveField(14)
  bool? fav;

  MovieDetails({this.adult, this.backdropPath, this.genreIds, this.id, this.originalLanguage, this.originalTitle, this.overview, this.popularity, this.posterPath, this.releaseDate, this.title, this.video, this.voteAverage, this.voteCount});

  MovieDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    fav = json['fav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['fav'] = fav;
    return data;
  }
}
