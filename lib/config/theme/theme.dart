import 'package:flutter/material.dart';

import 'color.dart';
import 'theme.enum.dart';

@immutable
class ITheme {
  final IColor color;
  late final TextStyle _textStyle;
  final double buttonBorderRadius;

  ITheme({
    required this.color,
    ThemeFontFamily fontFamily = ThemeFontFamily.Roboto,
    this.buttonBorderRadius = 3,
  }) {
    _textStyle = TextStyle(fontFamily: fontFamily.name);
  }

  TextStyle get titleStyle =>
      _textStyle..copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  TextStyle get subtitleStyle =>
      _textStyle..copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  TextStyle get buttonTextStyle =>
      _textStyle..copyWith(fontSize: 96, fontWeight: FontWeight.w700);

  ButtonStyle get buttonStyle => ButtonStyle(
        enableFeedback: true,
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        overlayColor: MaterialStateProperty.all(color.overlay.withOpacity(0.4)),
        backgroundColor: MaterialStateProperty.all<Color>(color.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius:
                    BorderRadius.all(Radius.circular(buttonBorderRadius)))),
        textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
      );

  AppBarTheme get appBarTheme =>
      AppBarTheme(color: color.primary, elevation: 0, centerTitle: true);

  ThemeData get themeData => ThemeData(
        fontFamily: _textStyle.fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: color.primary),
        appBarTheme: appBarTheme,
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      );
}
