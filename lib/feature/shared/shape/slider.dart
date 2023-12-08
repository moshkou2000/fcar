import 'package:flutter/material.dart';

import '../../../config/theme/theme_color.dart';

// when [sliderTheme.activeTrackColor] is null
const Color _activeTrackColor = ThemeColor.primary;

// when [sliderTheme.inactiveTrackColor] is null
final Color _inactiveTrackColor = Colors.grey[100]!;

// when [sliderTheme.thumbColor] is null
const Color _thumbColor = ThemeColor.primary;

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Fill the active track color
    final activeTrackLeft = trackRect.left;
    final activeTrackRight = thumbCenter.dx;
    final rectActive = Rect.fromLTRB(
        activeTrackLeft, trackRect.top, activeTrackRight, trackRect.bottom);
    final activeColor = sliderTheme.activeTrackColor ?? _activeTrackColor;
    final gradientActive = LinearGradient(
      // colors: [Colors.yellow, Colors.yellow, Colors.orange, Colors.orange],
      colors: [
        activeColor,
        activeColor,
        activeColor,
        activeColor,
        activeColor,
        Colors.transparent
      ],
    );
    context.canvas.drawRect(
      rectActive,
      Paint()..shader = gradientActive.createShader(rectActive),
    );

    // Fill the inactive track color
    final inactiveTrackLeft = thumbCenter.dx;
    final inactiveTrackRight = trackRect.right;
    final rectInactive = Rect.fromLTRB(
        inactiveTrackLeft, trackRect.top, inactiveTrackRight, trackRect.bottom);
    final inactiveColor = sliderTheme.inactiveTrackColor ?? _inactiveTrackColor;
    final gradientInactive = LinearGradient(colors: [
      Colors.transparent,
      inactiveColor,
      inactiveColor,
      inactiveColor,
      inactiveColor,
      inactiveColor,
    ]);
    context.canvas.drawRect(
      rectInactive,
      Paint()..shader = gradientInactive.createShader(rectInactive),
    );
  }
}

class StripedRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  final _stripeGap = 1.4; // gap of stripes
  final _stripeWidth = 6.0; // width of each stripe

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final dx = (_stripeWidth * _stripeGap).toInt();

    // Fill the active track color
    final activeTrackLeft = trackRect.left;
    for (var i = 0; i < trackRect.width; i += dx) {
      context.canvas.drawRect(
        Rect.fromLTWH(
            activeTrackLeft + i, trackRect.top, _stripeWidth, trackRect.height),
        Paint()..color = sliderTheme.activeTrackColor ?? _activeTrackColor,
      );
    }

    // Fill the inactive track color
    final inactiveTrackLeft = thumbCenter.dx;
    for (var i = 0; i < trackRect.width; i += dx) {
      context.canvas.drawRect(
        Rect.fromLTWH(inactiveTrackLeft + i, trackRect.top, _stripeWidth,
            trackRect.height),
        Paint()..color = sliderTheme.inactiveTrackColor ?? _inactiveTrackColor,
      );
      context.canvas.drawRect(
        Rect.fromLTWH(inactiveTrackLeft + i + _stripeWidth, trackRect.top,
            _stripeWidth, trackRect.height),
        Paint()..color = Colors.white,
      );
    }
  }
}

class RectangularSliderThumbShape extends SliderComponentShape {
  final double thumbHeight;
  final double thumbWeight;

  RectangularSliderThumbShape({
    this.thumbHeight = 10.0,
    this.thumbWeight = 10.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    double value = 0.0,
    double textScaleFactor = 1.0,
    Size? sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final rect = Rect.fromCenter(
      center: center,
      width: thumbWeight / 2,
      height: thumbHeight * 2,
    );

    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor ?? _thumbColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, thumbPaint);
  }
}
