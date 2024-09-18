import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final int? id;
  final String? displayname;
  final String? username;
  final String? accessToken;
  final String? refreshToken;

  const UserModel({
    this.id,
    this.displayname,
    this.username,
    this.accessToken,
    this.refreshToken,
  });

  bool get hasToken => accessToken != null && accessToken!.trim().isNotEmpty;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      displayname: map['displayname'] as String,
      username: map['username'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayname': displayname,
      'username': username,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(id: $id, displayname: $displayname, '
        'username: $username, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
