import 'package:flutter/material.dart';
import 'package:smart_rob/main/app_env.dart';

class AppConfig {
  const AppConfig._();

  static Duration networkTimeout = const Duration(seconds: 30);

  static const requestCanceled = 1001;
  static const connectionTimeout = 1002;
  static const receiveTimeout = 1003;
  static const unknownError = 1004;
  static const noInternetConnection = 1007;
  static const unexpectedCases = 1008;

  static String baseUrl = EnvInfo.connectionString;
  static const baseUrlVersion = 1;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class SizeConfig {
  static late BuildContext appContext;
  static late MediaQueryData _mediaQueryData;
  static late double? screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double height(double height) {
    final screenHeight = _mediaQueryData.size.height / 100;
    return height * screenHeight;
  }

  static double relHeight(double height) {
    final screenHeight = _mediaQueryData.size.height / 100;
    return (height / 8.12) * screenHeight;
  }

  static double relWidth(double width) {
    final screenWidth = _mediaQueryData.size.width / 100;
    return (width / 3.75) * screenWidth;
  }

  static double width(double width) {
    final screenWidth = _mediaQueryData.size.width / 100;
    return width * screenWidth;
  }

  static double textSize(double textSize) {
    final screenWidth = _mediaQueryData.size.width / 100;
    final screenHeight = _mediaQueryData.size.height / 100;
    return (((textSize / 3.75) * screenWidth) +
            (textSize / 8.12) * screenHeight) /
        2;
  }

  static double getBottomPadding() {
    return _mediaQueryData.padding.bottom;
  }

  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
}
