import 'package:flutter/material.dart';

import '../shared/player/player.widget.dart';
import '../shared/shape/player_painter.dart';
import 'home.argument.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.arguments, super.key});

  final HomeArgument arguments;

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 35, 141, 155),
      child: const Stack(
        children: [
          // PlayerWidget(
          //   arguments: null,
          // ),
        ],
      ),
    );
  }
}
