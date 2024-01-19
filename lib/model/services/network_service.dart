import 'dart:developer';
import 'dart:io';

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
    } on Exception catch (error, stack) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postWithoutAuth({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
        }),
      );

      debugPrint('response : ${response.data}');
      return response.data;
    } on DioException catch (error, stack) {
      debugPrint('error : ${error.message}');
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          // HttpHeaders.authorizationHeader: 'Bearer ${StorageService.getUser().accessToken}'
        }),
      );

      debugPrint('response : ${response.data}');
      return response.data;
    } on DioException catch (error, stack) {
      debugPrint('error : ${error.message}');
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error, stack) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error, stack) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
