import 'dart:convert';

import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/datasource/keystore/keystore.provider.dart';
import '../../core/datasource/network/network.provider.dart';
import '../../core/datasource/network/network_url.constant.dart';
import 'auth.model.dart';
import 'player.model.dart';

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  void getLocal() {
    // d.loadOne(query: d.box.query(AuthModel_.id.notNull()));
  }

  Future<AuthModel?> getUser() async {
    final result = await keystore.read(key: KeystoreKey.user);
    return result != null ? AuthModel.fromJson(result) : null;
  }

  Future<AuthModel?> login({
    required String username,
    required String password,
  }) async {
    // final url = NetworkUrl.login;
    // final body = <String, dynamic>{'username': username, 'password': password};
    // final json = await network.post(url, body: body);

    // this is mock data
    final dummy = await rootBundle.loadString('asset/mock/user.json');
    final dynamic json = jsonDecode(dummy);

    final result = Deserialize<AuthModel>(
      json,
      requiredFields: ['token', 'refreshToken', 'username', 'displayname'],
      fromMap: (e, {callback}) => AuthModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).item;
    return result;
  }

  Future<PlayerModel?> profile() async {
    // final url = NetworkUrl.profile;
    // final json = await network.get(url);

    // this is mock data
    final dummy = await rootBundle.loadString('asset/mock/profile.json');
    final dynamic json = jsonDecode(dummy);

    final result = Deserialize<PlayerModel>(
      json,
      requiredFields: [
        'username',
        'displayname',
        'rank',
        'avatar',
        'score',
        'group',
        'xp',
        'level',
        'coin',
        'point',
      ],
      fromMap: (e, {callback}) => PlayerModel.fromMap(e),
      callback: (m) =>
          logger.error(m), // you may log in Analytics/ErrorTracking
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
      requiredFields: ['token', 'refreshToken', 'username', 'displayname'],
      fromMap: (e, {callback}) => AuthModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
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

  Future<void> saveProfile({required String profile}) async {
    keystore.save(key: KeystoreKey.profile, value: profile);
  }

  Future<void> saveUser({required String user}) async {
    keystore.save(key: KeystoreKey.user, value: user);
  }
}
