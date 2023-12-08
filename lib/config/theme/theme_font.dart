import 'package:flutter/foundation.dart';
import 'package:fcar_lib/config/theme/font/roboto_style.dart';

@immutable
abstract final class ThemeFont {
  static final titleStyle = label500Medium;
  static final subtitleStyle = paragraph400Small;
  static final buttonTextStyle = paragraph400Medium;

  static final displayLarge = RobotoFont.displayLarge;
  static final displayMedium = RobotoFont.displayMedium;
  static final displaySmall = RobotoFont.displaySmall;

  static final headingXXLarge = RobotoFont.headingXXLarge;
  static final headingXLarge = RobotoFont.headingXLarge;
  static final headingLarge = RobotoFont.headingLarge;
  static final headingMedium = RobotoFont.headingMedium;
  static final headingSmall = RobotoFont.headingSmall;
  static final headingXSmall = RobotoFont.headingXSmall;

  static final label700Large = RobotoFont.label700Large;
  static final label700Medium = RobotoFont.label700Medium;
  static final label700Small = RobotoFont.label700Small;
  static final label700XSmall = RobotoFont.label700XSmall;

  static final label500Large = RobotoFont.label500Large;
  static final label500Medium = RobotoFont.label500Medium;
  static final label500Small = RobotoFont.label500Small;
  static final label500XSmall = RobotoFont.label500XSmall;

  static final paragraph400Large = RobotoFont.paragraph400Large;
  static final paragraph400Medium = RobotoFont.paragraph400Medium;
  static final paragraph400Small = RobotoFont.paragraph400Small;
  static final paragraph400XSmall = RobotoFont.paragraph400XSmall;
}
