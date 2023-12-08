import 'package:flutter/material.dart';

@immutable
abstract final class EnvConstant {
  static const String abcApiKey = String.fromEnvironment('ABC_API_KEY');

  /// during development in debug mode
  static const String username = String.fromEnvironment('AUTH_USERNAME');
  static const String password = String.fromEnvironment('AUTH_PASSWORD');
}
