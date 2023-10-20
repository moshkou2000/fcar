/// Export from [network.provider.dart]
///
class UrlConstant {
  static String login = '/auth/login';
  static String forgotPassword = '/auth/forgotPassword';
  static String abc({required int id}) => '/abc/$id';
  static String xyz({String? id}) => '/xyz/${id ?? 'latest'}';
}
