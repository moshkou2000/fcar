import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/config/extension/number.extension.dart';

import '../../auth/player.model.dart';

class CoinWidget extends ConsumerWidget {
  final PlayerModel playerInfo;
  const CoinWidget({required this.playerInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 50,
      left: 134,
      height: 40,
      width: 130,
      child: Stack(
        children: [
          // bar
          // coin value
          Positioned(
            top: 4,
            left: 24,
            child: Container(
              padding: const EdgeInsets.all(1),
              height: 22,
              width: 84,
              decoration: BoxDecoration(
                color: const Color(0xff1d3732),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  playerInfo.coin.toKMTnumber(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          // circle
          // token
          Positioned(
            top: 1,
            left: 0,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.yellow,
                  width: 3,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 0),
                    color: Colors.black87,
                  ),
                ],
              ),
              child: const Center(child: Text(r'$')),
            ),
          ),
          // square
          // add + button
          Positioned(
            top: 1,
            right: 0,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: const Color(0xff0374b5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color.fromARGB(255, 194, 194, 194),
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
              child: const Center(
                  child: Icon(
                Icons.add,
                color: Colors.white,
              )),
            ),
          )
        ],
      ),
    );
  }
}
