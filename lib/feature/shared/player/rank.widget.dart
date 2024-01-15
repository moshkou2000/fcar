import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RankWidget extends ConsumerWidget {
  final double left;
  final int? rank;
  const RankWidget({
    required this.left,
    this.rank,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 16,
      left: left - 16,
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
        child: Center(child: Text(rank != null ? rank.toString() : '')),
      ),
    );
  }
}
