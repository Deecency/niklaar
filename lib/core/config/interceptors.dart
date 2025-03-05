import 'dart:developer';

import 'package:dio/dio.dart';

import '../core.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor({required this.dio, required this.localRepository});

  final Dio dio;
  final LocalRepository localRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await localRepository.getAuthToken();

      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      } else {
        log('No user token ${options.uri}');
      }

      print('token $token');

      if (options.data is FormData) {
        final formData = options.data as FormData;

        for (final field in formData.fields) {
          print('  ${field.key}: ${field.value}');
        }

        for (final file in formData.files) {
          print('  ${file.key}: ${file.value.filename}');
        }
      }

      return super.onRequest(options, handler);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    handler.next(err);
  }

  /*  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    var options =
        Options(method: requestOptions.method, headers: requestOptions.headers);

    final token = await localRepository.getAuthToken();

    if (token != null) {
      options = Options(
        method: requestOptions.method,
        headers: options.headers
          ?..addAll({
            'Authorization': 'Bearer $token',
          }),
      );
    }

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  } */
}
