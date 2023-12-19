import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class LevelWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const LevelWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: 110,
      child: Column(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 92, 92, 92),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey,
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
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  child: SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        playerInfo.level.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 26,
                  left: 12,
                  child: Text(
                    'LVL',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
