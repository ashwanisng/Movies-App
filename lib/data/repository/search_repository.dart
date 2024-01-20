import 'package:flutter/material.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/model/services/network_service.dart';
import 'package:movie_app/utils/helper/exception_handler.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class SearchRepository {
  NetworkService controller = NetworkService();

  Future<RepoResponse<MovieResponse>> getMovieByGenre(String genreId) async {
    final response = await controller.get(
      path: Url.genre,
      query: {
        'language': 'en-US',
        'page': '1',
        'include_adult': true,
        'sort_by': 'popularity.desc',
        'with_genres': genreId,
      },
    );

    MovieResponse data = MovieResponse.fromJson(response);

    debugPrint('response :: ${data.movieDetails?.length}');

    return response is APIException
        ? RepoResponse(
            error: APIException(message: 'Something went wrong!'),
          )
        : RepoResponse(data: data);
  }

  Future<RepoResponse<MovieResponse>> searchMovies(String value) async {
    final response = await controller.get(
      path: Url.genre,
      query: {
        'language': 'en-US',
        'page': '1',
        'include_adult': true,
        'sort_by': 'popularity.desc',
        'query': value,
      },
    );

    MovieResponse data = MovieResponse.fromJson(response);

    debugPrint('response :: ${data.movieDetails?.length}');

    return response is APIException
        ? RepoResponse(
            error: APIException(message: 'Something went wrong!'),
          )
        : RepoResponse(data: data);
  }
}
