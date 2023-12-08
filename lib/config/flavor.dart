import 'dart:async';

import 'package:fcar_lib/core/service/monitoring/remote_config/firebase_remote_config.dart';
import 'package:fcar_lib/core/service/monitoring/error_tracking/firebase_error_tracking.dart';
import 'package:flutter/foundation.dart';
import 'package:fcar_lib/config/enum/app_env.enum.dart';

const String _defaultFlavorBaseUrl = 'abcd.api.ap-xyz.amazonaws.com';
const String _defaultFlavorSocketUrl = 'abcd.api.ap-xyz.amazonaws.com';

@immutable
abstract final class Flavor {
  static AppEnvironment env = AppEnvironment.dev;
  static FlavorSettings settings = FlavorSettings(
    baseUrl: _defaultFlavorBaseUrl,
    socketUrl: _defaultFlavorSocketUrl,
  );

  static String get baseUrl => settings.baseUrl;
  static String get socketUrl => settings.socketUrl;
  static String? get param1 => settings.param1;

  static Future<void> setup({required AppEnvironment env}) async {
    Flavor.env = env;
    final defaultParameters = <String, dynamic>{
      'baseUrl': _defaultFlavorBaseUrl,
      'socketUrl': _defaultFlavorSocketUrl,
      'param1': 'any param from remote',
    };
    try {
      // request default
      await FirebaseRemoteConfig.setup(
        env: env,
        defaultParameters: defaultParameters,
      );
      // get from remote
      settings = FlavorSettings(
        baseUrl: FirebaseRemoteConfig.getRemoteConfigValue(key: 'baseUrl'),
        socketUrl: FirebaseRemoteConfig.getRemoteConfigValue(key: 'socketUrl'),
        param1: FirebaseRemoteConfig.getRemoteConfigValue(key: 'param1'),
      );
    } catch (e, s) {
      // set default
      settings = FlavorSettings.fromMap(defaultParameters);
      FirebaseErrorTracking.recordError(e, s);
    }
  }
}

class FlavorSettings {
  final String baseUrl;
  final String socketUrl;
  String? param1;

  FlavorSettings({
    required this.baseUrl,
    required this.socketUrl,
    this.param1,
  });

  factory FlavorSettings.fromMap(Map<String, dynamic> map) {
    return FlavorSettings(
      baseUrl: map['baseUrl'] as String,
      socketUrl: map['socketUrl'] as String,
      param1: map['param1'] != null ? map['param1'] as String : null,
    );
  }
}
