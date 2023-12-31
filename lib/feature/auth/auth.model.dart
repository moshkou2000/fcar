import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class AuthModel {
  final int id;
  final String displayname;
  final String username;
  final String token;
  final String refreshToken;

  const AuthModel({
    required this.id,
    required this.displayname,
    required this.username,
    required this.token,
    required this.refreshToken,
  });

  bool get hasToken => token.trim().isNotEmpty;

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'] as int,
      displayname: map['displayname'] as String,
      username: map['username'] as String,
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayname': displayname,
      'username': username,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(id: $id, displayname: $displayname, '
        'username: $username, token: $token, refreshToken: $refreshToken)';
  }
}
