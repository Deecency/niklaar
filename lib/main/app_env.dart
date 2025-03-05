enum AppEnvironment { DEV, STAGING, PROD }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static set environment(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;
  static String get envName => _environment._envName;
  static String get connectionString => _environment._connectionString;
  static AppEnvironment get environment => _environment;
  static bool get isProduction => _environment == AppEnvironment.PROD;
}

extension _EnvProperties on AppEnvironment {
  String get _appTitle {
    switch (this) {
      case AppEnvironment.DEV:
        return 'Niklaar';
      case AppEnvironment.STAGING:
        return 'Niklaar';
      case AppEnvironment.PROD:
        return 'Niklaar';
    }
  }

  String get _connectionString {
    switch (this) {
      case AppEnvironment.DEV:
        return "https://api.paypointapp.africa/api";
      case AppEnvironment.STAGING:
        return 'CONNECTION_STRING_STAGING';
      case AppEnvironment.PROD:
        return "https://api.paypointapp.africa/api";
    }
  }

  String get _envName {
    switch (this) {
      case AppEnvironment.DEV:
        return 'dev';
      case AppEnvironment.STAGING:
        return 'staging';
      case AppEnvironment.PROD:
        return 'prod';
    }
  }
}
