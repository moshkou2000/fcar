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

  PlayerModel({
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
}
