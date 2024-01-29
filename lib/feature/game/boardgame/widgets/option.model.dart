import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'boardgame.enum.dart';

@immutable
class OptionModel {
  final String id;
  final String title;
  final BoardgameType type;
  final String url;

  const OptionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
  });

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      type: BoardgameType.fromString(map['type'] as String),
      url: map['url'] as String,
    );
  }

  factory OptionModel.fromJson(String source) =>
      OptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
