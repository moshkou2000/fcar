// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class OpponentModel {
  final String username;
  final String displayname;
  final String avatar;
  final int score;
  final int rank;

  const OpponentModel({
    required this.username,
    required this.displayname,
    required this.avatar,
    required this.score,
    required this.rank,
  });

  factory OpponentModel.fromMap(Map<String, dynamic> map) {
    return OpponentModel(
      username: map['username'] as String,
      displayname: map['displayname'] as String,
      avatar: map['avatar'] as String,
      score: map['score'] as int,
      rank: map['rank'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'displayname': displayname,
      'avatar': avatar,
      'score': score,
      'rank': rank,
    };
  }

  String toJson() => json.encode(toMap());

  factory OpponentModel.fromJson(String source) =>
      OpponentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlayerModel(username: $username, displayname: $displayname, '
        'avatar: $avatar, score: $score, rank: $rank)';
  }
}
