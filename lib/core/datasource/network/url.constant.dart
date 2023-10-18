/// Export from [network.provider.dart]
///
class UrlConstant {
  static String login = 'login';
  static String abc({required int id}) => '/abc/$id';
  static String xyz({String? id}) => '/xyz/${id ?? 'latest'}';
}
