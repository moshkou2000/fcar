import 'package:flutter/foundation.dart';

/// Export from [network.provider.dart]
///
@immutable
final class NetworkUrl {
  static String login = '/auth/login';
  static String profile = '/auth/profile';
  static String register = '/auth/register';
  static String forgotPassword = '/auth/forgotPassword';
  static String abc({required int id}) => '/abc/$id';
  static String xyz({String? id}) => '/xyz/${id ?? 'latest'}';
}
