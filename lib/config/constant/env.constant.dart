import 'package:flutter/material.dart';

@immutable
abstract final class EnvConstant {
  static String get abcApiKey => const String.fromEnvironment('ABC_API_KEY');

  /// during development in debug mode
  static String get username => const String.fromEnvironment('AUTH_USERNAME');
  static String get password => const String.fromEnvironment('AUTH_PASSWORD');
}
