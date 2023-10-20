// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'enum/app_env.dart';
import '../core/service/monitoring/error_tracking.module.dart';
import '../core/service/remote_config.service.dart';

const String _defaultFlavorBaseUrl = 'abcd.api.ap-xyz.amazonaws.com';

@immutable
abstract final class Flavor {
  static AppEnvironment env = AppEnvironment.dev;
  static FlavorSettings settings =
      FlavorSettings(baseUrl: _defaultFlavorBaseUrl);

  static String get baseUrl => settings.baseUrl;
  static String? get param1 => settings.param1;

  static Future<void> setup({required AppEnvironment env}) async {
    Flavor.env = env;
    final defaultParameters = <String, dynamic>{
      'baseUrl': _defaultFlavorBaseUrl,
      'param1': 'any param from remote',
    };
    try {
      // request default
      await remoteConfigService.init(
        defaultParameters: defaultParameters,
      );
      // get from remote
      settings = FlavorSettings(
        baseUrl: remoteConfigService.getRemoteConfigValue(key: 'baseUrl'),
        param1: remoteConfigService.getRemoteConfigValue(key: 'param1'),
      );
    } catch (e, s) {
      // set default
      settings = FlavorSettings.fromMap(defaultParameters);
      ErrorTracking.recordError(e, s);
    }
  }
}

class FlavorSettings {
  final String baseUrl;
  String? param1;

  FlavorSettings({
    required this.baseUrl,
    this.param1,
  });

  factory FlavorSettings.fromMap(Map<String, dynamic> map) {
    return FlavorSettings(
      baseUrl: map['baseUrl'] as String,
      param1: map['param1'] != null ? map['param1'] as String : null,
    );
  }
}
