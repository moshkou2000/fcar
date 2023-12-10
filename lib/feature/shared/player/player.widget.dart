import 'package:flutter/material.dart';

import '../shape/player_painter.dart';
import 'player.argument.dart';

class PlayerWidget extends StatelessWidget {
  final PlayerArgument arguments;

  const PlayerWidget({required this.arguments, super.key});

  @override
  Widget build(BuildContext context) {
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
