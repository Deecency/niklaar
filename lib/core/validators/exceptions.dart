// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/material.dart';

///This is the base class exception which can be
///used to throw with a message
class BaseException implements Exception {
  BaseException({this.message = 'Unknown Error'});
  final String? message;
}

///This class used to throw error from API Providers
@immutable
class APIException implements BaseException {
  const APIException({
    required this.errorCode,
    this.statusCode,
    this.statusMessage,
  });

  factory APIException.fromMap(Map<String, dynamic> map) {
    return APIException(
      statusCode: map['statusCode']?.toInt() as int,
      statusMessage: map['statusMessage'] as String?,
      errorCode: (map['errorCode'] as String?) ?? '',
    );
  }

  factory APIException.fromJson(String source) {
    final j = json.decode(source);

    if (j is Map<String, dynamic>) {
      return APIException.fromMap(j);
    }
    throw BaseException();
  }

  final int? statusCode;
  final String? statusMessage;
  final String errorCode;

  APIException copyWith({
    int? statusCode,
    String? statusMessage,
    String? errorCode,
  }) {
    return APIException(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'errorMessage': errorCode,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'APIException(statusCode: $statusCode, statusMessage: $statusMessage, errorCode: $errorCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is APIException &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode =>
      statusCode.hashCode ^ statusMessage.hashCode ^ errorCode.hashCode;

  @override
  String get message => errorCode;
}

class ErrorMessages {
  static String reqCanceled() => "Request was canceled.";
  static String connectionTimedOut() =>
      "Please check your internet connection.";
  static String receivedTimeout() => "Please check your internet connection.";
  static String somethingWentWrong() => "Something went wrong.";
  static String anIssueOccurred() => "An issue occurred.";
  static String unknownError() => "Unknown error.";
  static String noInternetConnection() => "No internet connection.";
  static String sendTimeout() => "Send timeout.";
  static String requestHeaderTooLarge() =>
      "Request header or cookie too large.";
  static String requestHeaderTooLargeContactSupport() =>
      "Request header or cookie too large. Please contact support.";
  static String noResponseDataAvailable() => "No response data available.";
  static String internalError() => "An internal error occurred.";
}
