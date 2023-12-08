import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class AuthModel {
  final int id;
  final String name;
  final String token;

  const AuthModel({
    required this.id,
    required this.name,
    required this.token,
  });

  bool get hasToken => token.trim().isNotEmpty;

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'] as int,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }
}
