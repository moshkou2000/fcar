import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'localization.enum.dart';
import 'localization_dictionary.dart';

class Localization extends LocalizationDictionary {
  static final Localization _singleton = Localization._internal();
  factory Localization() => _singleton;
  Localization._internal();

  static const List<LocalizationLanguage> supportedLanguages = [
    LocalizationLanguage.en,
    LocalizationLanguage.my,
  ];

  static LocalizationLanguage _language = LocalizationLanguage.en;
  static const Map<dynamic, dynamic> _localizedValues = {};

  static String get language => _language.name;
  static Iterable<Locale> get supportedLocales =>
      supportedLanguages.map<Locale>((e) => Locale(e.name, ''));

  /// Get the selected language from KeyStore
  static Future<void> setup({
    LocalizationLanguage language = LocalizationLanguage.en,
  }) async {
    _language = language;
    await _loadLocalizations(language.name);
  }

  static String text(String key) =>
      (_localizedValues[key] == null) ? '' : _localizedValues[key];

  static Future<void> _loadLocalizations(String language) async {
    final jsonContent =
        await rootBundle.loadString('asset/locale/$language.json');
    _localizedValues.addAll(json.decode(jsonContent));
  }
}
