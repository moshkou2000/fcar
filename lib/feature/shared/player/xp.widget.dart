import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class XpWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const XpWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpPercentage = playerInfo.xp.toDouble() / 10000;
    final xpLabel = playerInfo.xp;
    return Positioned(
      top: 8,
      left: 151,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(1),
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            child: LinearProgressIndicator(
              value: xpPercentage,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xff17a7c7)),
              backgroundColor: const Color(0xff1d3732),
            ),
          ),
        ),
        Positioned(
          top: 7,
          left: 12,
          child: Text(
            'XP',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        Positioned(
          top: 7,
          right: 8,
          child: Text(
            '$xpLabel',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
