import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class XpWidget extends ConsumerWidget {
  final int xp;
  final double width;
  final double height;
  final double left;
  const XpWidget({
    required this.xp,
    required this.width,
    required this.height,
    required this.left,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xpPercentage = xp.toDouble() / 10000;
    return Positioned(
      top: height / 3.3,
      left: left + 6,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(1),
          height: height,
          width: width,
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
          top: height / 4.1,
          left: 12,
          child: Text(
            'XP',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontSize: height / 2.2,
                ),
          ),
        ),
        Positioned(
          top: height / 4.1,
          right: 8,
          child: Text(
            xp.toString(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontSize: height / 2.2,
                ),
          ),
        ),
      ]),
    );
  }
}
