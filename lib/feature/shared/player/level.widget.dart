import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelWidget extends ConsumerWidget {
  final int level;
  final double width;
  final double left;
  const LevelWidget({
    required this.level,
    required this.width,
    required this.left,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: left + 10,
      child: Column(
        children: [
          Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 92, 92, 92),
              borderRadius: BorderRadius.circular(width / 2),
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
                  top: width / 8,
                  child: SizedBox(
                    width: width - 6,
                    child: Center(
                      child: Text(
                        level.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width / 3,
                            ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (width / 2),
                  left: -1,
                  width: width,
                  child: Center(
                    child: Text(
                      'LVL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white, fontSize: width / 4.6),
                    ),
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
