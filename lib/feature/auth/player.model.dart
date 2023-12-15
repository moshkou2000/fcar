// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class PlayerModel {
  final String username;
  final String displayname;
  final String avatar;
  final String group;
  final int score;
  final int rank;
  final int level;
  final int coin;
  final int point;

  const PlayerModel({
    required this.username,
    required this.displayname,
    required this.avatar,
    required this.group,
    required this.score,
    required this.rank,
    required this.level,
    required this.coin,
    required this.point,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      username: map['username'] as String,
      displayname: map['displayname'] as String,
      avatar: map['avatar'] as String,
      group: map['group'] as String,
      score: map['score'] as int,
      rank: map['rank'] as int,
      level: map['level'] as int,
      coin: map['coin'] as int,
      point: map['point'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'displayname': displayname,
      'avatar': avatar,
      'group': group,
      'score': score,
      'rank': rank,
      'level': level,
      'coin': coin,
      'point': point,
    };
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlayerModel(username: $username, displayname: $displayname, '
        'avatar: $avatar, group: $group, score: $score, rank: $rank, '
        'level: $level, coin: $coin, point: $point)';
  }
}
