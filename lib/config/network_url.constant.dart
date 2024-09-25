import 'package:flutter/foundation.dart';

/// Export from [network.provider.dart]
///
@immutable
final class NetworkUrl {
  static const String login = '/auth/login';
  static const String profile = '/player/profile';
  static const String opponent = '/player/opponent';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgotPassword';
  static const String question = '/gameplay/question';
  static const String selectedOption = '/gameplay/selectedOption';

  static String abc({required int id}) => '/abc/$id';
  static String xyz({String? id}) => '/xyz/${id ?? 'latest'}';
}
