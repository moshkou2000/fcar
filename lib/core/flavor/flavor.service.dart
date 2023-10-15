import 'dart:async';

import '../service/crashlytics/crashlytics.dart';
import '../service/remote_config.service.dart';
import '../../config/enum/app_env.dart';

FlavorService flavorService = FlavorService(env: AppEnvironment.dev);

const String _defaultFlavorBaseUrl = 'abcd.api.ap-xyz.amazonaws.com';

class FlavorService {
  static late FlavorService _instance;
  final AppEnvironment env;
  FlavorSettings settings;

  // FlavorSettings(baseUrl: 'abcd.api.ap-xyz.amazonaws.com');

  factory FlavorService({
    required AppEnvironment env,
    FlavorSettings? settings,
  }) =>
      _instance = FlavorService._internal(
          env: env,
          settings: settings ?? FlavorSettings(baseUrl: _defaultFlavorBaseUrl));

  FlavorService._internal({required this.env, required this.settings});

  static String get baseUrl => _instance.settings.baseUrl;

  static Future<void> setFlavor() async {
    try {
      await remoteConfigService.init(
        defaultParameters: <String, dynamic>{'baseUrl': _defaultFlavorBaseUrl},
      );
      _instance.settings = FlavorSettings(
          baseUrl: remoteConfigService.getRemoteConfigValue(key: 'baseUrl'));
    } catch (e, s) {
      _instance.settings = FlavorSettings(baseUrl: _defaultFlavorBaseUrl);
      Crashlytics.recordError(e, s);
    }
  }
}

class FlavorSettings {
  final String baseUrl;

  FlavorSettings({
    required this.baseUrl,
  });
}
