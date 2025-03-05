import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_rob/core/config/interceptors.dart';
import 'package:smart_rob/main/app_env.dart';
import 'package:smart_rob/repositories/auth/auth_repo.dart';
import 'package:smart_rob/screens/splash.dart';
import 'package:smart_rob/services/auth/auth_service.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'core/core.dart';

void main() => mainCommon(AppEnvironment.PROD);

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  WidgetsFlutterBinding.ensureInitialized();
  EnvInfo.environment = environment;

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalService>(create: (context) => LocalServiceImpl()..init()),
        Provider<LocalRepository>(
          create: (ctx) => LocalRepositoryImpl(localService: ctx.read()),
        ),
        Provider<AppTheme>(create: (ctx) => AppTheme(ctx.read())),

        Provider<Dio>(
          create: (ctx) {
            final dio = Dio(
              BaseOptions(connectTimeout: AppConfig.networkTimeout),
            );

            dio.interceptors.addAll([
              DioInterceptor(dio: dio, localRepository: ctx.read()),
              if (kDebugMode)
                TalkerDioLogger(
                  talker: ctx.read(),
                  settings: TalkerDioLoggerSettings(printRequestHeaders: true),
                ),
              InterceptorsWrapper(
                onResponse: (response, handler) {
                  if (response.statusCode == 204) {
                    return handler.reject(
                      DioException(
                        requestOptions: response.requestOptions,
                        response: response,
                        error: 'No Content',
                        type: DioExceptionType.badResponse,
                      ),
                    );
                  }
                  handler.next(response);
                },
              ),
            ]);

            return dio;
          },
        ),

        Provider<AuthService>(
          create: (ctx) => AuthService(ctx.read(), baseUrl: AppConfig.baseUrl),
        ),
        Provider<AuthRepository>(
          create: (ctx) => AuthRepositoryImpl(ctx.read()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(removeSplashLoader: false),
      ),
    ),
  );
}
