import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'player.controller.dart';

class AvatarWidget extends ConsumerWidget {
  final double width;
  final String? avatar;
  final String? heroTag;
  const AvatarWidget({
    required this.width,
    this.avatar,
    this.heroTag,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = width / 2;
    return Positioned(
      top: 4,
      left: 4,
      child: Container(
        padding: const EdgeInsets.all(3),
        height: width,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
        // avatar
        child: avatar == null
            ? _buildIndicator(ref, radius)
            : _buildAvatar(ref, radius),
      ),
    );
  }

  Widget _buildIndicator(WidgetRef ref, double radius) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      enabled: true,
      child: _buildAvatar(ref, radius),
    );
  }

  Widget _buildAvatar(WidgetRef ref, double radius) {
    return Hero(
      tag: heroTag ?? DateTime.now().millisecondsSinceEpoch.toString(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: avatar != null
            ? GestureDetector(
                onTap: () =>
                    ref.read(playerController.notifier).navigateToAbout(),
                // TODO: the Image must be from [Network]
                child: Image.asset(
                  avatar!,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }
}
