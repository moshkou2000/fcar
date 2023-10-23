import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'localization.enum.dart';
import 'localization_dictionary.dart';

/// call [setup] at the highest order before [runApp]
///
/// Use [text] to get respective text from localization dictionary.
/// Use [supportedLanguages] in the main (MaterialApp)
/// get languages as Local [supportedLocales]
/// get String [language]
///
class Localization extends LocalizationDictionary {
  static final Localization _singleton = Localization._internal();
  factory Localization() => _singleton;
  Localization._internal();

  static const List<LocalizationLanguage> supportedLanguages = [
    LocalizationLanguage.en,
    LocalizationLanguage.my,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('my'),
  ];

  static LocalizationLanguage _language = LocalizationLanguage.en;
  static final Map<dynamic, dynamic> _localizedValues = {};

  static String get language => _language.name;

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
