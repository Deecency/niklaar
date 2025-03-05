import 'package:flutter/material.dart';

class AppColors {
  static bool isDarkMode = false;

  static Color getColor(Color lightColor, Color darkColor) {
    return isDarkMode ? darkColor : lightColor;
  }

  static Color get bg {
    return getColor(Color(0XFFFFFFFF), const Color(0xFF121212));
  }

  static Color get primary => getColor(Color(0xFF1F3669), const Color(0xFFFF8559));

  static Color get secondary => getColor(Color(0xEE009EEA), const Color(0xFF9ED75E));

  static Color primary900 = primary.withValues(alpha: 0.9);
  static Color primary800 = primary.withValues(alpha: 0.8);
  static Color primary700 = primary.withValues(alpha: 0.7);
  static Color primary600 = primary.withValues(alpha: 0.6);
  static Color primary500 = primary.withValues(alpha: 0.5);
  static Color primary400 = primary.withValues(alpha: 0.4);
  static Color primary300 = primary.withValues(alpha: 0.3);
  static Color primary200 = primary.withValues(alpha: 0.2);
  static Color primary100 = primary.withValues(alpha: 0.1);
  static Color primaryLight = primary.lighten(0.697);

  static Color secondary900 = secondary.withValues(alpha: 0.9);
  static Color secondary800 = secondary.withValues(alpha: 0.8);
  static Color secondary700 = secondary.withValues(alpha: 0.7);
  static Color secondary600 = secondary.withValues(alpha: 0.6);
  static Color secondary500 = secondary.withValues(alpha: 0.5);
  static Color secondary400 = secondary.withValues(alpha: 0.4);
  static Color secondary300 = secondary.withValues(alpha: 0.3);
  static Color secondary200 = secondary.withValues(alpha: 0.2);
  static Color secondary100 = secondary.withValues(alpha: 0.1);

  static Color secondaryShadeLight = const Color(0xffD9ECC6);

  static Color get secondaryShade => getColor(const Color(0xFFDEFFBB), const Color(0xFF4A5F2E));

  static Color get error => getColor(const Color(0xFFEB5757), const Color(0xFFFF544A));

  static Color get success => getColor(const Color(0xFF219653), const Color(0xFF2ECC71));

  static Color get black {
    return getColor(const Color(0xFF000000), const Color(0xFFFFFFFF));
  }

  static Color get black100 => getColor(const Color(0xFFF1F1F1), Colors.white12);

  static Color get black200 => getColor(const Color(0xFFE5E5E5), const Color(0xFFCCCCCC));

  static Color get black300 => getColor(const Color(0xFFC3C3C3), const Color(0xFFB3B3B3));

  static Color get black400 => getColor(const Color(0xFF979797), const Color(0xFF999999));

  static Color get white => getColor(const Color(0xFFFFFFFF), const Color(0xFF000000));

  static Color get border => getColor(const Color(0xFFDADADA), const Color(0xFF000000));

  static Color get white50 => getColor(
    const Color(0xFFf4f4f4),
    const Color(0xFF1A1A1A), // Very dark gray
  );

  static Color get yellow => getColor(const Color(0xFFF5BA00), const Color(0xFFFFD54F));

  static Color get yellowLight => getColor(const Color(0xFFFFEEBA), const Color(0xFF8B7355));

  // Error states
  static Color get error700 => getColor(const Color(0xFFBD0A00), const Color(0xFFFF6B6B));

  static Color get error400 => getColor(const Color(0xFFFF544A), const Color(0xFFFF8A80));

  static Color get error100 => getColor(const Color(0xFFFFCECB), const Color(0xFF663333));

  static Color get errorLight => getColor(const Color(0xFFFEEBEB), const Color(0xFF482C2C));

  static Color get errorDark => getColor(const Color(0xFFE10E0E), const Color(0xFFFF5252));

  // Pending states
  static Color get pending => getColor(const Color(0xFFFFFBEB), const Color(0xFF433B26));

  static Color get pendingDark => getColor(const Color(0xFFD97706), const Color(0xFFFFA726));

  static Color get pendingMedium => getColor(const Color(0xFFFF9F0A), const Color(0xFFFFB74D));

  // Brand colors
  static Color get green => getColor(const Color(0xFF659C2C), const Color(0xFF81C784));

  static Color get purple => getColor(const Color(0xFFA359E8), const Color(0xFFB39DDB));

  static Color get blue => getColor(const Color(0xFF248BC6), const Color(0xFF64B5F6));

  static Color get tierBlue => getColor(const Color(0xFF2F80ED), const Color(0xFF42A5F5));

  static Color get tierPurple => getColor(const Color(0xFF5D5FEF), const Color(0xFF7986CB));

  static Color get pink => getColor(const Color(0xFFDA4B94), const Color(0xFFF06292));

  // Success states
  static Color get successLight => getColor(const Color(0XFFDAF8E6), const Color(0xFF2E4A3A));

  static Color get successDark => getColor(const Color(0XFF1A8245), const Color(0xFF66BB6A));
}

extension ColorUtils on Color {
  Color lighten(double factor) {
    assert(factor >= 0.0 && factor <= 1.0, 'Factor must be between 0.0 and 1.0');

    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + (1.0 - hsl.lightness) * factor).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  Color darken(double factor) {
    assert(factor >= 0.0 && factor <= 1.0, 'Factor must be between 0.0 and 1.0');

    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness * (1 - factor)).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  double get opacity => a / 0xFF;
}
