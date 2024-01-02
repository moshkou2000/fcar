import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class RankWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const RankWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 16,
      left: 86,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 216, 216),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 92, 92, 92),
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 0),
              color: Colors.black87,
            ),
          ],
        ),
        child: Center(child: Text(playerInfo.rank.toString())),
      ),
    );
  }
}
