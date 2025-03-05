import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class Themes {
  static ThemeData get theme {
    AppColors.isDarkMode = false;
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.primary),
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.white,
        onSurface: AppColors.black,
        outlineVariant: AppColors.black400,
        outline: AppColors.black400,
      ),
      highlightColor: AppColors.primary300,
      indicatorColor: AppColors.primary,
      hoverColor: AppColors.secondary,
      focusColor: AppColors.secondary,
      disabledColor: AppColors.black200,
      cardColor: AppColors.bg,
      canvasColor: AppColors.bg,
      progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.primary),
      buttonTheme: const ButtonThemeData(colorScheme: ColorScheme.light()),
      iconTheme: IconThemeData(color: AppColors.black400),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        shadowColor: AppColors.black.withValues(alpha: 0.1),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.black,
          statusBarIconBrightness: Brightness.light,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.black),
        displayMedium: TextStyle(color: AppColors.black),
        displaySmall: TextStyle(color: AppColors.black),
        headlineLarge: TextStyle(color: AppColors.black),
        headlineMedium: TextStyle(color: AppColors.black),
        headlineSmall: TextStyle(color: AppColors.black),
        titleLarge: TextStyle(color: AppColors.black),
        titleMedium: TextStyle(color: AppColors.black400),
        titleSmall: TextStyle(color: AppColors.black400),
        bodyLarge: TextStyle(color: AppColors.black),
        bodyMedium: TextStyle(color: AppColors.black400),
        bodySmall: TextStyle(color: AppColors.black300),
        labelLarge: TextStyle(color: AppColors.black),
        labelMedium: TextStyle(color: AppColors.black400),
        labelSmall: TextStyle(color: AppColors.black300),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    AppColors.isDarkMode = true;
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(0xFF777E90)),
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.white,
        onSurface: AppColors.black,
        outlineVariant: AppColors.black400,
        outline: AppColors.black400,
      ),
      focusColor: AppColors.secondary,
      disabledColor: AppColors.black200,
      cardColor: AppColors.bg,
      canvasColor: AppColors.bg,
      buttonTheme: const ButtonThemeData(colorScheme: ColorScheme.light()),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.primary),
      iconTheme: IconThemeData(color: AppColors.black400),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        shadowColor: AppColors.black.withValues(alpha: 0.1),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: AppColors.black,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      scaffoldBackgroundColor: AppColors.bg,
      indicatorColor: AppColors.primary,
      hintColor: const Color(0xff280C0B),
      highlightColor: AppColors.primary300,
      hoverColor: AppColors.secondary,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.black),
        displayMedium: TextStyle(color: AppColors.black),
        displaySmall: TextStyle(color: AppColors.black),
        headlineLarge: TextStyle(color: AppColors.black),
        headlineMedium: TextStyle(color: AppColors.black),
        headlineSmall: TextStyle(color: AppColors.black),
        titleLarge: TextStyle(color: AppColors.black),
        titleMedium: TextStyle(color: AppColors.black400),
        titleSmall: TextStyle(color: AppColors.black400),
        bodyLarge: TextStyle(color: AppColors.black),
        bodyMedium: TextStyle(color: AppColors.black400),
        bodySmall: TextStyle(color: AppColors.black300),
        labelLarge: TextStyle(color: AppColors.black),
        labelMedium: TextStyle(color: AppColors.black400),
        labelSmall: TextStyle(color: AppColors.black300),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      useMaterial3: true,
    );
  }
}
