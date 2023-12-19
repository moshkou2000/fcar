import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'avatar.widget.dart';
import 'coin.widget.dart';
import 'displayname.widget.dart';
import 'level.widget.dart';
import 'player.controller.dart';
import 'rank.widget.dart';
import 'score.widget.dart';
import 'xp.widget.dart';

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({super.key});

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final info = ref.watch(playerController);

    if (info == null) return const SizedBox();

    return Stack(children: [
      const SizedBox(width: 300),
      ScoreWidget(playerInfo: info),
      AvatarWidget(playerInfo: info),
      DisplaynameWidget(playerInfo: info),
      RankWidget(playerInfo: info),
      XpWidget(playerInfo: info),
      LevelWidget(playerInfo: info),
      CoinWidget(playerInfo: info),
    ]);
  }
}
