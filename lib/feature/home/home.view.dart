import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/player/player.widget.dart';
import 'home.argument.dart';

class HomeView extends ConsumerStatefulWidget {
  final HomeArgument arguments;
  const HomeView({required this.arguments, super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 122, 145),
      child: const Stack(
        children: [
          Positioned(
            top: 40,
            left: 10,
            child: PlayerWidget(),
          ),
        ],
      ),
    );
  }
}
