import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/core/datasource/network/deserialize.dart';

import '../../core/datasource/keystore/keystore.provider.dart';
import '../../core/datasource/network/network.provider.dart';
import '../../core/datasource/network/network_url.constant.dart';
import 'auth.model.dart';

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  void getLocal() {
    // d.loadOne(query: d.box.query(AuthModel_.id.notNull()));
  }

  Future<AuthModel?> login({
    required String username,
    required String password,
  }) async {
    final url = NetworkUrl.login;
    final body = <String, dynamic>{'username': username, 'password': password};
    final json = await network.post(url, body: body);
    final result = Deserialize<AuthModel>(
      json,
      requiredFields: ['accessToken', 'refreshToken', 'id'],
      fromJson: (e, {callback}) => AuthModel.fromMap(e),
    ).item;
    return result;
  }

  Future<AuthModel?> register({
    required String email,
    required String password,
  }) async {
    final url = NetworkUrl.register;
    final body = <String, dynamic>{'email': email, 'password': password};
    final json = await network.post(url, body: body);
    final result = Deserialize<AuthModel>(
      json,
      requiredFields: ['accessToken', 'refreshToken', 'id'],
      fromJson: (e, {callback}) => AuthModel.fromMap(e),
    ).item;
    return result;
  }

  Future<bool> forgotPassword({required String email}) async {
    final url = NetworkUrl.forgotPassword;
    final body = <String, dynamic>{'email': email};
    final json = await network.post(url, body: body);
    final result = Deserialize<bool>(
      json,
      key: 'success',
    ).item;
    return result ?? false;
  }

  Future<void> saveUser({required Object user}) async {
    keystore.save(key: KeystoreKey.user, value: user);
  }
}
