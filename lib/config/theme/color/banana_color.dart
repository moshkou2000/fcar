/// Reference in color.dart
///
import 'package:flutter/material.dart';

@immutable
abstract final class ThemeColor {
  static const primary = Color(0xFFFDCF33);
  static const onPrimary = Color(0xFF3D82C3);
  static const primaryContainer = Color(0xFF173559);
  static const onPrimaryContainer = Color(0xFF998F01);

  static const secondary = Color(0xffac3306);
  static const onSecondary = Color(0xFFB6AA01);
  static const secondaryContainer = Color(0xffffdbcf);
  static const onSecondaryContainer = Color(0xFF8C3D0E);

  static const tertiary = Color(0xff006875);
  static const onTertiary = Color(0xFFE9D900);
  static const tertiaryContainer = Color(0xFF7DD6B0);
  static const onTertiaryContainer = Color(0xFFFFEE00);

  static const error = Color(0xFF92192C);
  static const onError = Color(0xFFBB2020);
  static const errorContainer = Color(0xFFECF3F9);

  static const background = Color(0xffffffff);
  static const onBackground = Color(0xffffffff);

  static const surface = Color(0xff141617);
  static const onSurface = Color(0xff141617);
  static const surfaceVariant = Color(0xff181b1e);
  static const onSurfaceVariant = Color(0xff181b1e);

  static const inverseSurface = Color(0xfffcfdff);
  static const inversePrimary = Color(0xff506273);
  static const outline = Color(0xff959999);
  static const shadow = Color(0xff000000);
  static const overlay = Color.fromRGBO(0, 0, 0, 0.6);
}
