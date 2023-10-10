import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

LocalizationService localizationService = LocalizationService();

const List<String> _supportedLanguages = ['en', 'my'];

class LocalizationService {
  String _language = 'en';
  Map<dynamic, dynamic>? _localizedValues;

  static final LocalizationService _localizationService =
      LocalizationService._internal();
  factory LocalizationService() => _localizationService;
  LocalizationService._internal();

  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  String text(String key) =>
      (_localizedValues == null || _localizedValues![key] == null)
          ? '** $key not found'
          : _localizedValues![key];

  // TODO: get the selected language from KeyStore
  Future<void> init({String? language}) async {
    if (language != null) {
      _setLanguage(language);
    }
    _loadLocalizations(_language);
  }

  void _setLanguage(String language) {
    _language = language;
  }

  Future<void> _loadLocalizations(String language) async {
    final jsonContent =
        await rootBundle.loadString('asset/locale/$language.json');
    _localizedValues = json.decode(jsonContent);
  }
}
