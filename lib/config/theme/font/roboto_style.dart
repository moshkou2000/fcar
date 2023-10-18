import 'package:flutter/material.dart';

@immutable
class RobotoStyle {
  static const _defaultStyle = TextStyle(fontFamily: 'Roboto');

  TextStyle get defaultStyle => _defaultStyle;

  static final displayLarge =
      _defaultStyle.copyWith(fontSize: 96, fontWeight: FontWeight.w700);
  static final displayMedium =
      _defaultStyle.copyWith(fontSize: 52, fontWeight: FontWeight.w700);
  static final displaySmall =
      _defaultStyle.copyWith(fontSize: 44, fontWeight: FontWeight.w700);

  static final headingXXLarge =
      _defaultStyle.copyWith(fontSize: 40, fontWeight: FontWeight.w700);
  static final headingXLarge =
      _defaultStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w700);
  static final headingLarge =
      _defaultStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w700);
  static final headingMedium =
      _defaultStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w700);
  static final headingSmall =
      _defaultStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700);
  static final headingXSmall =
      _defaultStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700);

  static final label700Large =
      _defaultStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700);
  static final label700Medium =
      _defaultStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  static final label700Small =
      _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final label700XSmall =
      _defaultStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w700);

  static final label500Large =
      _defaultStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500);
  static final label500Medium =
      _defaultStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  static final label500Small =
      _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static final label500XSmall =
      _defaultStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  static final paragraph400Large =
      _defaultStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w400);
  static final paragraph400Medium =
      _defaultStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  static final paragraph400Small =
      _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  static final paragraph400XSmall =
      _defaultStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
}
