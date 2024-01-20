import 'package:movie_app/data/response/response.dart';
import 'package:movie_app/model/services/network_service.dart';
import 'package:movie_app/utils/helper/exception_handler.dart';
import 'package:movie_app/utils/values/url.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class MovieRepository {
  NetworkService controller = NetworkService();

  Future<RepoResponse<MovieResponse>> getPopularMovies(int pageNo) async {
    final response = await controller.get(
      path: Url.popularMovieUrl,
      query: {
        'language': 'en-US',
        'page': pageNo.toString(),
      },
    );

    MovieResponse data = MovieResponse.fromJson(response);

    return response is APIException ? RepoResponse(error: APIException(message: 'Something went wrong!')) : RepoResponse(data: data);
  }

  Future<RepoResponse<MovieResponse>> getSimilarMovies(int movieId, int pageNo) async {
    final response = await controller.get(
      path: Url.similarMovies(movieId),
      query: {'language': 'en-US', 'page': pageNo.toString()},
    );

    MovieResponse data = MovieResponse.fromJson(response);

    return response is APIException ? RepoResponse(error: APIException(message: 'Something went wrong!')) : RepoResponse(data: data);
  }
}
