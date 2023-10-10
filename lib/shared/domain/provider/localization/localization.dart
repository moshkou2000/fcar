import 'localization.service.dart';

Localization localization = Localization();

class Localization {
// a
  String get all => localizationService.text('all');
  String get apply => localizationService.text('apply');
  String get are => localizationService.text('are');
  String get assign => localizationService.text('assign');

// c
  String get camera => localizationService.text('camera');
  String get cancel => localizationService.text('cancel');

// e
  String get error => localizationService.text('error');

// n
  String get noInternet => localizationService.text('noInternet');

// u
  String get unauthorized => localizationService.text('unauthorized');
}
