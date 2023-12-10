import 'package:flutter/material.dart';

class PlayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const colorOne = Colors.white;
    final colorTwo = Colors.red[200]!;
    final colorThree = Colors.red[100]!;
    const radius = 60.0;

    final paint = Paint();

    final outerRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);

    // const thickness = 10.0;
    // final innerRect = Rect.fromCircle(
    //     center: Offset(size.width / 2, size.height / 2),
    //     radius: radius - thickness);

    final Gradient gradient = RadialGradient(
      colors: [
        colorOne,
        colorOne,
        colorTwo,
        colorThree
      ], // Customize gradient colors
      stops: const [0.0, 0.8, 0.8, 1.0],
    );
    final gradientShader = gradient.createShader(outerRect);

    paint.shader = gradientShader;

    // Draw the filled circle with gradient
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class PlayerPainter2 extends CustomPainter {
  Color colorOne = Colors.red[400]!;
  Color colorTwo = Colors.red[300]!;
  Color colorThree = Colors.red[100]!;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    const radius = 4.0;

    paint.color = colorOne;
    canvas.drawRRect(
        const RRect.fromLTRBXY(0, 0, 100, 30, radius, radius), paint);

    paint.color = colorTwo;
    canvas.drawRRect(
        const RRect.fromLTRBXY(0, 30, 80, 20, radius, radius), paint);

    paint.color = colorThree;
    canvas.drawRRect(
        const RRect.fromLTRBXY(0, 50, 70, 20, radius, radius), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
