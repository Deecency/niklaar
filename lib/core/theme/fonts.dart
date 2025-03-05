import 'package:flutter/material.dart';

import '../config/app_config.dart';

class AppFonts {
  static TextStyle get w800 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle get w700 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get w600 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get w500 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get w400 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get w300 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle get w100 {
    final context = AppConfig.navigatorKey.currentContext;
    return TextStyle(
      fontFamily: 'Proxima Nova',
      color: context?.textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w100,
    );
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
