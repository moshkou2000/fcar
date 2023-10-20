import 'package:flutter/material.dart';

@immutable
abstract final class EnvConstant {
  // TODO: seperate the keys for services by the provider name

  static const String abcApiKey = String.fromEnvironment('ABC_API_KEY');
  static const String analyticsApiKey =
      String.fromEnvironment('ANALYTICS_API_KEY');

  static const String datadogClientToken =
      String.fromEnvironment('ANALYTICS_API_KEY');
  static const String datadogApplicationId =
      String.fromEnvironment('ANALYTICS_API_KEY');
  static const String sentryDsn = String.fromEnvironment('ABC_API_KEY');

  static const String username = String.fromEnvironment('AUTH_USERNAME');
  static const String password = String.fromEnvironment('AUTH_PASSWORD');
}
