class Url {
  static const popularMovieUrl = "/movie/popular";
  static similarMovies(int movieId) => "/movie/$movieId/similar";
  static const genre = "/discover/movie";
  static const search = "/search/movie";

  static const imageBaseUrlW400 = "https://image.tmdb.org/t/p/w400";

  static const imageBaseUrlW500 = "https://image.tmdb.org/t/p/w500";

  static const imageBaseUrlW185 = "https://image.tmdb.org/t/p/w185";
}
