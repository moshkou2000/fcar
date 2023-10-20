import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../../../../config/enum/app_env.dart';
import '../monitoring.enum.dart';
import 'sentry.dart';

@immutable
abstract final class Analytics {
  static init({required AppEnvironment env}) => Sentry.init(env: env);

  static Future<void> clear() async {
    await setUser(userId: null);
  }

  static Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    // logEvent(eventName: eventName, data: data);
    package.Sentry.captureMessage(
      event.name,
      level: package.SentryLevel.info,
      params: data?.keys.map((e) => '$e:${data[e]}').toList(),
      hint: data != null
          ? package.Hint.withMap(Map<String, Object>.from(data))
          : null,
    );
  }

  static Future<void> setUser({String? userId}) async {
    package.Sentry.configureScope(
      (scope) => scope.setUser(package.SentryUser(id: userId)),
    );
  }
}
