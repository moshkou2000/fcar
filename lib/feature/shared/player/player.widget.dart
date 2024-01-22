import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../about/about.view.dart';
import 'avatar.widget.dart';
import 'coin.widget.dart';
import 'displayname.widget.dart';
import 'level.widget.dart';
import 'player.controller.dart';
import 'rank.widget.dart';
import 'score.widget.dart';
import 'xp.widget.dart';

const _widthAvatar = 90.0;
const _widthLevel = 44.0;

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

    // Relative size
    final widthContainer = MediaQuery.of(context).size.width;
    final widthXp =
        widthContainer - _widthAvatar - _widthLevel /*threshold*/ - 80;
    const heightXp = _widthLevel / 1.6;
    const leftXp = _widthAvatar + _widthLevel;
    const leftAvatar = _widthAvatar + _widthLevel;

    return Stack(children: [
      SizedBox(
        width: widthContainer,
        height: _widthAvatar + 8,
      ),
      ScoreWidget(score: info.score, width: _widthAvatar),
      AvatarWidget(
        avatar: info.avatar,
        width: _widthAvatar,
        heroTag: heroTagAboutView,
      ),
      DisplaynameWidget(displayname: info.displayname, width: _widthAvatar),
      RankWidget(
        rank: info.rank,
        left: _widthAvatar,
      ),
      XpWidget(
        xp: info.xp,
        width: widthXp,
        height: heightXp,
        left: leftXp,
      ),
      LevelWidget(level: info.level, width: _widthLevel, left: _widthAvatar),
      CoinWidget(coin: info.coin, top: _widthLevel, left: leftAvatar),
    ]);
  }
}
