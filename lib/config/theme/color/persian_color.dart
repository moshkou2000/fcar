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
  static const errorContainer = Color(0xFFECF3F9);
  static const surface = Color(0xff141617);
  static const surfaceVariant = Color(0xff181b1e);
  static const inverseSurface = Color(0xfffcfdff);
  static const inversePrimary = Color(0xff506273);
  static const outline = Color(0xff959999);
  static const background = Color(0xff191b1f);
  static const shadow = Color(0xff000000);
  static const overlay = Color.fromRGBO(0, 0, 0, 0.6);
}


/*
@import "~@angular/material/theming";
@import "./variables.scss";
@include mat-core();

$persian-blue-palette: (
  50: #e8eafa,
  100: #c5c9f2,
  200: #9da7e9,
  300: #7484e1,
  400: #5368da,
  500: #2e4cd2,
  600: #2844c7,
  700: #1c39bb,
  800: #0e2eb0,
  900: #00189d,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);
$persian-medium-blue-palette: (
  50: #e3f2f8,
  100: #baddf0,
  200: #90c9e8,
  300: #68b3de,
  400: #48a3d9,
  500: #2995d4,
  600: #1d87c8,
  700: #0e76b6,
  800: #0066a5,
  900: #004986,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);

$persian-indigo-palette: (
  50: #ece5f3,
  100: #cec0e2,
  200: #ae97ce,
  300: #8f6dbb,
  400: #784ead,
  500: #61309f,
  600: #592c9a,
  700: #4e2491,
  800: #431e89,
  900: #31127a,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);
$persian-rose-palette: (
  50: #fde4f3,
  100: #fabce1,
  200: #fa8fcc,
  300: #fc5cb6,
  400: #fe28a1,
  500: #ff008b,
  600: #f00087,
  700: #d80080,
  800: #c2007c,
  900: #980073,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);
$persian-pink-palette: (
  50: #fde1ef,
  100: #f9b3d8,
  200: #f77fbd,
  300: #f344a0,
  400: #ee0088,
  500: #eb006f,
  600: #d9006c,
  700: #c30066,
  800: #ad0062,
  900: #85005a,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);
$persian-red-palette: (
  50: #ffeaec,
  100: #ffcbcd,
  200: #f39791,
  300: #e96e66,
  400: #f14d3e,
  500: #f53d1d,
  600: #e6321e,
  700: #d52619,
  800: #c81d11,
  900: #ba0900,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);

$persian-orange-palette: (
  50: #fefded,
  100: #fdf9d2,
  200: #fbf5b5,
  300: #faf09c,
  400: #f8eb89,
  500: #f5e67a,
  600: #f6db78,
  700: #eec56f,
  800: #e7b167,
  900: #d99058,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);

$persian-plum-palette: (
  50: #ffddc1,
  100: #ffbca8,
  200: #ec9987,
  300: #cc7763,
  400: #b55c49,
  500: #9d412f,
  600: #91372a,
  700: #802b21,
  800: #701c1c,
  900: #5e0914,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);
$persian-green-palette: (
  50: #dff2f0,
  100: #afdfd8,
  200: #7bcbbf,
  300: #42b6a5,
  400: #00a693,
  500: #009680,
  600: #008973,
  700: #007964,
  800: #006955,
  900: #004d3a,
  A100: #add1ff,
  A200: #7ab5ff,
  A400: #4798ff,
  A700: #2e8aff,
  contrast: (
    50: $dark-primary-text,
    100: $dark-primary-text,
    200: $dark-primary-text,
    300: $dark-primary-text,
    400: $dark-primary-text,
    500: $light-primary-text,
    600: $light-primary-text,
    700: $light-primary-text,
    800: $light-primary-text,
    900: $light-primary-text,
    A100: $dark-primary-text,
    A200: $dark-primary-text,
    A400: $dark-primary-text,
    A700: $light-primary-text,
  ),
);

$app-primary: mat-palette($persian-medium-blue-palette);
$app-accent: mat-palette($persian-green-palette);
$app-warn: mat-palette($persian-rose-palette);
$theme: mat-light-theme($app-primary, $app-accent, $app-warn);
@include angular-material-theme($theme);

.alternate-theme {
  $alternate-primary: mat-palette($mat-light-blue);
  $alternate-accent: mat-palette($mat-yellow, 400);
  $alternate-theme: mat-light-theme($alternate-primary, $alternate-accent);
  @include angular-material-theme($alternate-theme);
}
*/