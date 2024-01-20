import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/helper/exception_handler.dart';
import 'package:movie_app/utils/values/constants.dart';
import 'package:movie_app/utils/values/env.dart';

class NetworkService {
  late Dio _dio;

  NetworkService() {
    prepareRequest();
  }

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: Timeouts.CONNECT_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: Timeouts.RECEIVE_TIMEOUT),
      baseUrl: Env.baseURL,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {'Accept': Headers.jsonContentType},
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: _printLog,
    ));
  }

  _printLog(Object object) => log(object.toString());

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDQxMWRhZmJiYmYwYjk5ZjRiZjg4NzA4OGViMGY3ZSIsInN1YiI6IjY1YThlMDNhNmY5NzQ2MDEyZWQ4ZmI2ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Nk03GocXafJENJru8LHd4P0Th8i08Fu2z4DPWebi0_U",
        }),
      );
      debugPrint('====== ${response.statusCode} =====');
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }
}
