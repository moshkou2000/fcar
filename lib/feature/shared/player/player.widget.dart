import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';
import '../shape/player_painter.dart';
import 'player.controller.dart';

class PlayerWidget extends ConsumerWidget {
  final PlayerModel? playerInfo;
  const PlayerWidget({this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerController);
    final _ = state ?? playerInfo;

    logger.info(_);

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 300,
          child: CustomPaint(
            painter: PlayerPainter(),
            child: Container(
              height: 300,
            ),
          ),
        ),
      ],
    );
  }
}
