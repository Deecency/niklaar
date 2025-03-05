import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

/// Abstract class of AuthService
@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/auth/register/step-one")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<HttpResponse<dynamic>> registerUser(
    @Part(name: 'last_name') String lastName,
    @Part(name: 'first_name') String firstName,
    @Part(name: 'phone_number') String phoneNumber,
    @Part(name: 'email') String email,
  );

  @POST("/auth/register/profile_level_1")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<HttpResponse<dynamic>> completeRegistration(
    @Part(name: 'password') String password,
    @Part(name: 'password_confirmation') String passwordConfirmation,
    @Part(name: 'username') String username,
    @Part(name: 'referral') String referral,
  );
}
