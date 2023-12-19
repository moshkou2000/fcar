import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class AvatarWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const AvatarWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 4,
      left: 4,
      child: Container(
        padding: const EdgeInsets.all(3),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        // avatar
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            playerInfo.avatar,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
