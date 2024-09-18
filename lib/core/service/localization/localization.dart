import 'package:flutter/material.dart';

import 'package:fcar_lib/core/service/localization/localization.provider.dart';

@immutable
abstract final class Localization {
// a
  static String get all => LocalizationProvider.text('all');
  static String get apply => LocalizationProvider.text('apply');
  static String get are => LocalizationProvider.text('are');
  static String get assign => LocalizationProvider.text('assign');
  static String get authentication =>
      LocalizationProvider.text('authentication');

// c
  static String get camera => LocalizationProvider.text('camera');
  static String get cancel => LocalizationProvider.text('cancel');

// e
  static String get error => LocalizationProvider.text('error');
  static String get exit => LocalizationProvider.text('exit');
  static String get exitDescription =>
      LocalizationProvider.text('exitDescription');

// o
  static String get ok => LocalizationProvider.text('ok');

// n
  static String get noInternet => LocalizationProvider.text('noInternet');

// u
  static String get unauthorized => LocalizationProvider.text('unauthorized');
}
