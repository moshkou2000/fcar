import 'package:flutter/material.dart';

import '../color.dart';

class BananaColor implements IColor {
  static final BananaColor _singleton = BananaColor._internal();
  factory BananaColor() => _singleton;
  BananaColor._internal();

  @override
  Color get primary => const Color(0xff004881);
  @override
  Color get onPrimary => const Color(0xFF817800);
  @override
  Color get primaryContainer => const Color(0xffd0e4ff);
  @override
  Color get onPrimaryContainer => const Color(0xFF998F01);
  @override
  Color get secondary => const Color(0xffac3306);
  @override
  Color get onSecondary => const Color(0xFFB6AA01);
  @override
  Color get secondaryContainer => const Color(0xffffdbcf);
  @override
  Color get onSecondaryContainer => const Color(0xFFCFC202);
  @override
  Color get tertiary => const Color(0xff006875);
  @override
  Color get onTertiary => const Color(0xFFE9D900);
  @override
  Color get tertiaryContainer => const Color(0xff95f0ff);
  @override
  Color get onTertiaryContainer => const Color(0xFFFFEE00);
  @override
  Color get error => const Color(0xffb00020);
  @override
  Color get errorContainer => const Color(0xFFB0001D);

  @override
  Color get surface => const Color(0xff141617);
  @override
  Color get surfaceVariant => const Color(0xff181b1e);
  @override
  Color get inverseSurface => const Color(0xfffcfdff);
  @override
  Color get inversePrimary => const Color(0xff506273);

  @override
  Color get outline => const Color(0xff959999);
  @override
  Color get background => const Color(0xff191b1f);
  @override
  Color get shadow => const Color(0xff000000);
  @override
  Color get overlay => const Color.fromRGBO(0, 0, 0, 0.6);

  final yellow = const Color(0xFFFDCF33);
  final lightBlue = const Color(0xFF3D82C3);
  final darkBlue = const Color(0xFF173559);

  final blue100 = const Color(0xFFECF3F9);
  final blue150 = const Color(0xFFD9F2FC);
  final blue200 = const Color(0xFFB1CDE7);
  final blue300 = const Color(0xFF3D82C3);
  final blue400 = const Color(0xFF1E4B8C);

  final green100 = const Color(0xFFD6F4E8);
  final green200 = const Color(0xFF7DD6B0);
  final green300 = const Color(0xFF44BC8A);
  final green400 = const Color(0xFF0A6653);

  final orange100 = const Color(0xFFFFE8CC);
  final orange200 = const Color(0xFFFDB967);
  final orange300 = const Color(0xFFF4911B);
  final orange400 = const Color(0xFF8C3D0E);

  final red100 = const Color(0xFFFFEDEB);
  final red200 = const Color(0xFFF4988B);
  final red300 = const Color(0xFFE9280D);
  final red400 = const Color(0xFF92192C);

  final white = const Color(0xFFFFFFFF);
  final grey50 = const Color(0xFFF4F6F8);
  final grey100 = const Color(0xFFE6EBF2);
  final grey200 = const Color(0xFFD5DCE5);
  final grey300 = const Color(0xFFB3BAC3);
  final grey400 = const Color(0xFF959CA4);
  final grey500 = const Color(0xFF696C71);
  final grey600 = const Color(0xFF2E2E2E);
  final darkGrey = const Color.fromRGBO(35, 31, 32, 0.8);
  final lightGrey = const Color.fromRGBO(35, 31, 32, 0.24);
  final grey = const Color.fromRGBO(35, 31, 32, 0.56);
  final shade30 = const Color(0xFFB2B2B2);
  final shade50 = const Color(0xFF808080);

  final black = const Color(0xFF000000);

  final List<Color> placeholder = [
    const Color.fromRGBO(35, 31, 32, 0.08),
    const Color.fromRGBO(35, 31, 32, 0.16)
  ];

  final List<Color> gradient40 = [
    const Color.fromRGBO(0, 0, 0, 0.4),
    const Color.fromRGBO(0, 0, 0, 0.0),
  ];
  final List<Color> gradientInverse40 = [
    const Color.fromRGBO(0, 0, 0, 0.0),
    const Color.fromRGBO(0, 0, 0, 0.4),
  ];
  final List<Color> gradient60 = [
    const Color.fromRGBO(0, 0, 0, 0.6),
    const Color.fromRGBO(0, 0, 0, 0.0),
  ];
  final List<Color> gradientInverse60 = [
    const Color.fromRGBO(0, 0, 0, 0.0),
    const Color.fromRGBO(0, 0, 0, 0.6),
  ];

  final List<BoxShadow> shadow01 = [
    const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.16),
        blurRadius: 4,
        offset: Offset(0, 2))
  ];
  final List<BoxShadow> shadowInverse01 = [
    const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.16),
        blurRadius: 4,
        offset: Offset(0, -2))
  ];
  final List<BoxShadow> shadow02 = [
    const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.16),
        blurRadius: 8,
        offset: Offset(0, 4))
  ];
  final List<BoxShadow> shadowInverse02 = [
    const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.16),
        blurRadius: 8,
        offset: Offset(0, -4))
  ];
}
