import 'package:flutter/material.dart';

abstract class IColor {
  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get secondary;
  Color get onSecondary;
  Color get secondaryContainer;
  Color get onSecondaryContainer;
  Color get tertiary;
  Color get onTertiary;
  Color get tertiaryContainer;
  Color get onTertiaryContainer;
  Color get error;
  Color get errorContainer;

  Color get surface;
  Color get surfaceVariant;
  Color get inverseSurface;
  Color get inversePrimary;

  Color get outline;
  Color get background;
  Color get shadow;
  Color get overlay;
}
