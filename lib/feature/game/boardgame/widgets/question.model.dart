import 'dart:convert';

import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:flutter/foundation.dart';

import 'boardgame.enum.dart';
import 'option.model.dart';

@immutable
class QuestionModel {
  final String id;
  final String title;
  final BoardgameType type;
  final String url;
  final List<OptionModel> options;

  const QuestionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    required this.options,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final result = Deserialize<OptionModel>(
      map,
      key: 'options',
      requiredFields: ['id', 'title', 'type', 'url'],
      fromMap: (e, {callback}) => OptionModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).items;

    return QuestionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      type: BoardgameType.fromString(map['type'] as String),
      url: map['url'] as String,
      options: result,
    );
  }

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
