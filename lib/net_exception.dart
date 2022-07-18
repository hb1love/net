import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'net_exception.freezed.dart';

@freezed
class NetException with _$NetException {
  const factory NetException.badRequest() = BadRequest;

  const factory NetException.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetException.notFound() = NotFound;

  const factory NetException.internalServerError() = InternalServerError;

  const factory NetException.serviceUnavailable() = ServiceUnavailable;

  const factory NetException.noInternetConnection() = NoInternetConnection;

  const factory NetException.timeout() = RequestTimeout;

  const factory NetException.formatException() = FormatException;

  const factory NetException.unableToProcess() = UnableToProcess;

  const factory NetException.defaultError(String error) = DefaultError;

  const factory NetException.unexpectedError() = UnexpectedError;

  factory NetException.fromObj(Object e) {
    if (e is NetException) {
      return e;
    } else if (e is DioError) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          return const NetException.timeout();
        case DioErrorType.response:
          switch (e.response?.statusCode) {
            case 400:
              return const NetException.badRequest();
            case 401:
              return const NetException.unauthorisedRequest();
            case 404:
              return const NetException.notFound();
            case 500:
              return const NetException.internalServerError();
            case 503:
              return const NetException.serviceUnavailable();
            default:
              var responseCode = e.response?.statusCode;
              return NetException.defaultError(
                  'Received invalid status code: $responseCode');
          }
        default:
          return const NetException.unexpectedError();
      }
    } else if (e is SocketException) {
      return const NetException.noInternetConnection();
    } else if (e is FormatException) {
      return const NetException.formatException();
    }
    return const NetException.unexpectedError();
  }

  static String getErrorMessage(NetException netException) {
    var errorMessage = "";
    netException.when(badRequest: () {
      errorMessage = 'Bad request';
    }, unauthorisedRequest: () {
      errorMessage = 'Unauthorised request';
    }, notFound: () {
      errorMessage = 'Not found';
    }, internalServerError: () {
      errorMessage = 'Internal Server Error';
    }, serviceUnavailable: () {
      errorMessage = 'Service unavailable';
    }, noInternetConnection: () {
      errorMessage = 'No Internet Connection';
    }, timeout: () {
      errorMessage = 'Timeout';
    }, formatException: () {
      errorMessage = 'Unable to process the data';
    }, unableToProcess: () {
      errorMessage = 'Unable to process the data';
    }, defaultError: (String error) {
      errorMessage = error;
    }, unexpectedError: () {
      errorMessage = 'Unexpected error occurred';
    });
    return errorMessage;
  }
}
