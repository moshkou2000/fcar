class EnvConstant {
  static const String abcApiKey = String.fromEnvironment('ABC_API_KEY');
  static const String analyticsApiKey =
      String.fromEnvironment('ANALYTICS_API_KEY');
  static const String username = String.fromEnvironment('AUTH_USERNAME');
  static const String password = String.fromEnvironment('AUTH_PASSWORD');
}
