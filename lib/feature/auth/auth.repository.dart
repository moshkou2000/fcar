import '../../core/datasource/network/deserialize.dart';
import '../../core/datasource/network/url.constant.dart';
import 'auth.model.dart';

class Auth {
  void getLocal() {
    // d.loadOne(query: d.box.query(AuthModel_.id.notNull()));
  }

  Future<AuthModel?> login(String? username, String? password) async {
    final url = UrlConstant.login;
    final body = <String, dynamic>{'username': username, 'password': password};
    // final dynamic json = await network.post(url, body: body);
    // Deserialize<AuthModel>(
    //   json,
    //   requiredFields: ['accessToken', 'refreshToken', 'id'],
    //   fromJson: (e, {callback}) => AuthModel.fromMap(e),
    // ).item;
    return null;
  }
}
