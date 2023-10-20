import '../../core/datasource/network.provider.dart';
import 'auth.model.dart';

class Auth {
  void getLocal() {
    // d.loadOne(query: d.box.query(AuthModel_.id.notNull()));
  }

  Future<AuthModel?> login({
    required String username,
    required String password,
  }) async {
    final url = UrlConstant.login;
    final body = <String, dynamic>{'username': username, 'password': password};
    final json = await network.post(url, body: body);
    final result = Deserialize<AuthModel>(
      json,
      requiredFields: ['accessToken', 'refreshToken', 'id'],
      fromJson: (e, {callback}) => AuthModel.fromMap(e),
    ).item;
    return result;
  }

  Future<bool> forgotPassword({required String email}) async {
    final url = UrlConstant.forgotPassword;
    final body = <String, dynamic>{'email': email};
    final json = await network.post(url, body: body);
    final result = Deserialize<bool>(
      json,
      key: 'success',
    ).item;
    return result ?? false;
  }
}
