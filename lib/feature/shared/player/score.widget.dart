import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class ScoreWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const ScoreWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        height: 108,
        width: 108,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 0),
              color: Colors.black87,
            ),
          ],
        ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Transform.rotate(
            angle: 123.4,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              // strokeAlign: -0.4,
              strokeWidth: 4,
              backgroundColor: Colors.grey,
              value: playerInfo.score.toDouble() / 10000,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ),
      ),
    );
  }
}
