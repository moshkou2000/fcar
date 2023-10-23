/// Reference in font_style.dart
///
import 'package:flutter/material.dart';

@immutable
abstract final class ThemeFont {
  static const fontFamily = 'Roboto';
  static const textStyle = TextStyle(fontFamily: fontFamily);

  static final titleStyle = label500Medium;
  static final subtitleStyle = paragraph400Small;
  static final buttonTextStyle = paragraph400Medium;

  static final displayLarge =
      textStyle.copyWith(fontSize: 96, fontWeight: FontWeight.w700);
  static final displayMedium =
      textStyle.copyWith(fontSize: 52, fontWeight: FontWeight.w700);
  static final displaySmall =
      textStyle.copyWith(fontSize: 44, fontWeight: FontWeight.w700);

  static final headingXXLarge =
      textStyle.copyWith(fontSize: 40, fontWeight: FontWeight.w700);
  static final headingXLarge =
      textStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w700);
  static final headingLarge =
      textStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w700);
  static final headingMedium =
      textStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w700);
  static final headingSmall =
      textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700);
  static final headingXSmall =
      textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700);

  static final label700Large =
      textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700);
  static final label700Medium =
      textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  static final label700Small =
      textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final label700XSmall =
      textStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w700);

  static final label500Large =
      textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500);
  static final label500Medium =
      textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  static final label500Small =
      textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static final label500XSmall =
      textStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  static final paragraph400Large =
      textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w400);
  static final paragraph400Medium =
      textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  static final paragraph400Small =
      textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  static final paragraph400XSmall =
      textStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
}
