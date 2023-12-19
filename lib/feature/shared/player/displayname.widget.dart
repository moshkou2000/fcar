import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';

class DisplaynameWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const DisplaynameWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 3,
      left: 10,
      width: 90,
      child: Container(
        padding: const EdgeInsets.all(1),
        height: 24,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black87,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 2),
              color: Colors.black87,
            ),
          ],
        ),
        child: Center(
          child: Text(
            playerInfo.displayname,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
