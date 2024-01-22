import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreWidget extends ConsumerWidget {
  final int score;
  final double width;
  const ScoreWidget({
    required this.score,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = width / 2;
    final w = width + 8;
    return Positioned(
      top: 0,
      left: 0,
      height: w,
      width: w,
      child: Container(
        height: w,
        width: w,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 0),
              color: Colors.black87,
            ),
          ],
        ),
        child: SizedBox(
          width: width,
          height: width,
          child: Transform.rotate(
            angle: 123.4,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              // strokeAlign: -0.4,
              strokeWidth: 2,
              backgroundColor: Colors.grey,
              value: score.toDouble() / 10000,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ),
      ),
    );
  }
}
