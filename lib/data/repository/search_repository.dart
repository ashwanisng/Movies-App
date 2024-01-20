import 'package:flutter/material.dart';
import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/model/services/network_service.dart';
import 'package:movie_app/utils/helper/exception_handler.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/search/data/model/genre_response.dart';

class SearchRepository {
  NetworkService controller = NetworkService();

  Future<RepoResponse<GenreResponse>> getMovieByGenre(String genreId) async {
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

    GenreResponse data = GenreResponse.fromJson(response);

    debugPrint('response :: ${data.genreDetails?.length}');

    return response is APIException
        ? RepoResponse(
            error: APIException(message: 'Something went wrong!'),
          )
        : RepoResponse(data: data);
  }

  Future<RepoResponse<GenreResponse>> searchMovies(String value) async {
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

    GenreResponse data = GenreResponse.fromJson(response);

    debugPrint('response :: ${data.genreDetails?.length}');

    return response is APIException
        ? RepoResponse(
            error: APIException(message: 'Something went wrong!'),
          )
        : RepoResponse(data: data);
  }
}
