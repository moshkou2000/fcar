import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class AnswerModel {
  final bool playerAnswer;
  final bool opponentAnswer;

  const AnswerModel({
    required this.playerAnswer,
    required this.opponentAnswer,
  });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      playerAnswer: map['playerAnswer'] as bool,
      opponentAnswer: map['opponentAnswer'] as bool,
    );
  }

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
