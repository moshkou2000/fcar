import 'package:flutter/material.dart';

class RobotoStyle {
  static TextStyle defaultStyle = const TextStyle(fontFamily: 'Roboto');

  static TextStyle h1 =
      defaultStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w700);

  static TextStyle h2 =
      defaultStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle h3 =
      defaultStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700);

  static TextStyle h4 =
      defaultStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700);

  static TextStyle h5 =
      defaultStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w400);

  static TextStyle button =
      defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700);

  static TextStyle subtitle = defaultStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subtitle2 = defaultStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body1 = defaultStyle.copyWith(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.3);

  static TextStyle body2 = defaultStyle.copyWith(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2);

  static TextStyle caption = defaultStyle.copyWith(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0);

  static TextStyle caption2 = defaultStyle.copyWith(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0);

  static TextStyle overLine = defaultStyle.copyWith(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0.5);
}
