import 'package:flutter/foundation.dart';

/// Export from [network.provider.dart]
///
@immutable
final class NetworkUrl {
  static String login = '/auth/login';
  static String profile = '/player/profile';
  static String opponent = '/player/opponent';
  static String register = '/auth/register';
  static String forgotPassword = '/auth/forgotPassword';
  static String question = '/gameplay/question';
  static String selectedOption = '/gameplay/selectedOption';
  static String abc({required int id}) => '/abc/$id';
  static String xyz({String? id}) => '/xyz/${id ?? 'latest'}';
}
