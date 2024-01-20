import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/values/strings.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static APIException handleError(Exception error) {
    if (error is DioException) {
      if (error.response?.statusCode == 503 || error.response?.statusCode == 500 || error.response?.statusCode == 404 || error.response?.statusCode == 403) {
        return HandleError.handleError(APIException(message: 'Service Unavailable'));
      }
      switch (error.type) {
        case DioExceptionType.sendTimeout:
          return APIException(message: ErrorMessages.noInternet);
        case DioExceptionType.connectionTimeout:
          return APIException(message: ErrorMessages.connectionTimeout);
        case DioExceptionType.badResponse:
          return APIException(message: error.response?.data);
        default:
          return APIException(message: ErrorMessages.networkGeneral);
      }
    } else {
      return APIException(message: ErrorMessages.networkGeneral);
    }
  }
}

class HandleError {
  HandleError._privateConstructor();

  static handleError(APIException? error) {
    debugPrint('APIException: ${error?.message}');
  }
}
