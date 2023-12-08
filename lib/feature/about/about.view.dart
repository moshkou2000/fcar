import 'package:flutter/material.dart';

import '../shared/shared.module.dart';
import 'about.argument.dart';

class AboutView extends StatefulWidget {
  const AboutView({required this.arguments, super.key});

  final AboutArgument arguments;

  @override
  State<AboutView> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 300,
          child: CustomPaint(
            painter: CurvePainter(),
            child: Container(
              height: 300,
            ),
          ),
        ),
      ],
    );
  }
}
