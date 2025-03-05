import 'package:dio/dio.dart';
import 'package:smart_rob/core/validators/error_handler.dart';
import 'package:smart_rob/core/validators/exceptions.dart';
import 'package:smart_rob/services/auth/auth_service.dart';

class ApiResult<T> {
  ErrorHandler? exception;
  T? data;
}

/// Abstract class of AuthRepository
abstract class AuthRepository {
  Future<ApiResult<dynamic>> registerStepOne({
    required String lastName,
    required String firstName,
    required String phoneNumber,
    required String email,
  });

  Future<ApiResult<dynamic>> register({
    required String userName,
    required String referral,
    required String password,
    required String passwordConfirmation,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.authService);

  final AuthService authService;

  @override
  Future<ApiResult<dynamic>> registerStepOne({
    required String lastName,
    required String firstName,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      final res = await authService.registerUser(
        lastName,
        firstName,
        phoneNumber,
        email,
      );
      if (res.response.statusCode != null && res.response.statusCode! > 201) {
        throw APIException(
          statusMessage: ' Failed to make request',
          errorCode: '422',
          statusCode: res.response.statusCode,
        );
      }
      return ApiResult<dynamic>()..data = res.data;
    } catch (e, s) {
      print('Failed to register $e, $s');

      if (e is DioException) {
        return ApiResult<String>()
          ..exception = ErrorHandler.dioException(error: e);
      }

      return ApiResult<String>()
        ..exception = ErrorHandler.otherException(error: e);
    }
  }

  @override
  Future<ApiResult> register({
    required String userName,
    required String referral,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final res = await authService.completeRegistration(
        password,
        passwordConfirmation,
        userName,
        referral,
      );
      if (res.response.statusCode != null && res.response.statusCode! > 201) {
        throw APIException(
          statusMessage: ' Failed to make request',
          errorCode: '422',
          statusCode: res.response.statusCode,
        );
      }
      return ApiResult<dynamic>()..data = res.data;
    } catch (e, s) {
      print('Failed to register $e, $s');

      if (e is DioException) {
        return ApiResult<String>()
          ..exception = ErrorHandler.dioException(error: e);
      }

      return ApiResult<String>()
        ..exception = ErrorHandler.otherException(error: e);
    }
  }
}
