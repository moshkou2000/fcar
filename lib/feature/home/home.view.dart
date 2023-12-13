import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/player/player.widget.dart';
import 'home.argument.dart';

class HomeView extends ConsumerStatefulWidget {
  final HomeArgument arguments;
  const HomeView({required this.arguments, super.key});

  @override
  ConsumerState<HomeView> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 35, 141, 155),
      child: const Stack(
        children: [
          PlayerWidget(),
        ],
      ),
    );
  }
}
