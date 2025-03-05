// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rob/core/validators/exceptions.dart';

import '../config/app_config.dart' show AppConfig;

class ErrorHandler implements Exception {
  ErrorHandler(this._errorMessage, this._statusCode, {this.showError = true});

  ErrorHandler.otherException({dynamic error, this.showError = true}) {
    _errorHandler(error);
  }

  ErrorHandler.dioException({
    required DioException error,
    this.showError = true,
  }) {
    _errorHandler(error);
  }

  final bool showError;
  String _errorMessage = '';
  String? _errorCode;
  int _statusCode = 0;

  String getErrorMessage() {
    return _errorMessage;
  }

  String? getErrorCode() {
    return _errorCode;
  }

  int getStatusCode() {
    return _statusCode;
  }

  Future<void> _errorHandler(dynamic error) async {
    if (error is DioException) {
      await _handleDioException(error).then((e) {
        if (showError && e != null) {
          _displayError(e: e);
        }
      });
    } else if (error is Map<String, dynamic>) {
      _errorMessage = error['error'] ?? ErrorMessages.unknownError();
      _statusCode = error['statusCode'];
      await _handleOtherException(_errorMessage, _statusCode).then((e) {
        if (showError) {
          _displayError(e: e);
        }
      });
    } else if (error is BaseException) {
      _errorMessage = error.message ?? ErrorMessages.somethingWentWrong();
      await _handleOtherException(error.message, null).then((e) {
        if (showError) {
          _displayError(
            e: APIException(
              errorCode: error.message ?? ErrorMessages.internalError(),
            ),
          );
        }
      });
    } else if (error is APIException) {
      if (showError) {
        _displayError(e: error);
      }
    }
  }

  Future<APIException> _handleOtherException(String? msg, int? code) async {
    final errorMessage = ErrorMessages.internalError();
    final statusMessage = msg ?? '';
    final statusCode = code ?? AppConfig.unknownError;
    return APIException(
      errorCode: errorMessage,
      statusCode: statusCode,
      statusMessage: statusMessage,
    );
  }

  Future _handleDioException(DioException error) async {
    var resMessage = '';
    var errorCode = '';
    var statusCode = 0;

    switch (error.type) {
      case DioExceptionType.cancel:
        resMessage = 'Request Canceled';
        statusCode = error.response?.statusCode ?? AppConfig.requestCanceled;
        break;
      case DioExceptionType.connectionTimeout:
        statusCode = error.response?.statusCode ?? AppConfig.connectionTimeout;
        resMessage = ErrorMessages.connectionTimedOut();
        break;
      case DioExceptionType.receiveTimeout:
        statusCode = error.response?.statusCode ?? AppConfig.receiveTimeout;
        resMessage = ErrorMessages.receivedTimeout();
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500 &&
            error.response!.statusCode! < 600) {
          statusCode = error.response!.statusCode!;
          try {
            final responseData =
                (error.response?.data is String &&
                        error.response!.data.isNotEmpty)
                    ? jsonDecode(error.response!.data) as Map<String, dynamic>
                    : error.response?.data;

            final errors =
                (responseData is Map<String, dynamic>)
                    ? responseData['errors']
                    : responseData;

            if (errors is List && errors.isNotEmpty) {
              resMessage = errors.first['errorMessage'];
            } else if (errors is String && errors.isNotEmpty) {
              if (errors.startsWith('<html>') || errors.contains('<body>')) {
                resMessage = ErrorMessages.anIssueOccurred();
              } else {
                resMessage = errors;
              }
            }
          } catch (e) {
            resMessage = ErrorMessages.anIssueOccurred();
          }
        } else if (error.response?.statusCode != 401) {
          if (error.response?.data is Map<String, dynamic>) {
            if (error.response?.data['errors'] is List) {
              errorCode =
                  error.response?.data['errors'][0]['errorCode'] ?? 'null';
            }

            resMessage = _handleBadRequest(
              error.response?.data as Map<String, dynamic>,
            );
          } else if (error.response?.data != null &&
              error.response?.data is String) {
            try {
              final eData =
                  jsonDecode(error.response!.data) as Map<String, dynamic>;
              resMessage = _handleBadRequest(eData);
              if (eData['errors'] != null && eData['errors'] is List) {
                errorCode = eData['errors'][0]['errorCode'] ?? 'null';
              }
            } catch (e) {
              if (error.response?.data is String &&
                  error.response!.data.contains(
                    ErrorMessages.requestHeaderTooLarge(),
                  )) {
                resMessage = ErrorMessages.requestHeaderTooLarge();
              } else {
                resMessage = ErrorMessages.somethingWentWrong();
              }
            }
          } else {
            resMessage = ErrorMessages.noResponseDataAvailable();
          }
          statusCode = error.response?.statusCode ?? AppConfig.unknownError;
        } else {
          resMessage = ErrorMessages.somethingWentWrong();
          statusCode = error.response!.statusCode!;

          final responseData =
              (error.response?.data is String &&
                      error.response!.data.isNotEmpty)
                  ? jsonDecode(error.response!.data) as Map<String, dynamic>
                  : error.response?.data;

          final errors =
              (responseData is Map<String, dynamic>)
                  ? responseData['errors']
                  : responseData;

          if (errors is List && errors.isNotEmpty) {
            resMessage = errors.first['errorMessage'];
          } else if (errors is String && errors.isNotEmpty) {
            if (errors.startsWith('<html>') || errors.contains('<body>')) {
              resMessage = ErrorMessages.anIssueOccurred();
            } else {
              resMessage = errors;
            }
          }
        }
        break;
      case DioExceptionType.unknown:
        resMessage = ErrorMessages.somethingWentWrong();
        statusCode = error.response?.statusCode ?? AppConfig.unknownError;
        break;
      case DioExceptionType.sendTimeout:
        resMessage =
            kReleaseMode
                ? ErrorMessages.somethingWentWrong()
                : ErrorMessages.sendTimeout();
        statusCode = error.response?.statusCode ?? AppConfig.receiveTimeout;
        break;
      case DioExceptionType.connectionError:
        resMessage = ErrorMessages.noInternetConnection();
        statusCode = AppConfig.noInternetConnection;
        break;
      case DioExceptionType.badCertificate:
        resMessage =
            error.response?.statusMessage ?? ErrorMessages.somethingWentWrong();
        statusCode = error.response?.statusCode ?? AppConfig.unknownError;
        break;
    }

    _errorMessage = resMessage;
    _errorCode = errorCode;
    return APIException(
      errorCode: errorCode,
      statusCode: statusCode,
      statusMessage: resMessage,
    );
  }

  String _handleBadRequest(Map<String, dynamic>? errorData) {
    if (errorData == null) return ErrorMessages.somethingWentWrong();

    try {
      if (errorData.containsKey('data')) {
        final data = errorData['data'] as Map<String, dynamic>;

        String message =
            data['message']?.toString() ?? ErrorMessages.somethingWentWrong();

        if (data.containsKey('error') &&
            data['error'] is Map<String, dynamic>) {
          final errors = data['error'] as Map<String, dynamic>;

          final errorMessages = errors.entries
              .map((entry) {
                final errorList = entry.value as List;
                return errorList.join(", ");
              })
              .join("\n");

          return "$message - $errorMessages".trim();
        }

        return message;
      }
    } catch (e) {
      return ErrorMessages.somethingWentWrong();
    }

    return ErrorMessages.somethingWentWrong();
  }

  void _displayError({required APIException e, data}) {
    var errorData = <String, dynamic>{};
    errorData = {
      'error': e.errorCode,
      'message':
          _statusCode == AppConfig.noInternetConnection
              ? ErrorMessages.noInternetConnection()
              : e.statusMessage,
      'statusCode': e.statusCode,
      'loginData': data,
    };

    showErrorModal(errorData);
  }
}

Future<void> showErrorModal(Map<String, dynamic> error) async {
  final context = AppConfig.navigatorKey.currentContext;
  if (context != null) {}
}
