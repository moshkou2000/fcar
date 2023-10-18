import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../analytics.dart';
import '../monitoring.enum.dart';
import 'sentry.dart';

class SentryAnalytics extends Sentry implements IAnalytics {
  static final SentryAnalytics _singleton = SentryAnalytics._internal();
  factory SentryAnalytics() => _singleton;
  SentryAnalytics._internal();

  @override
  NavigatorObserver observer =
      package.SentryNavigatorObserver(setRouteNameAsTransaction: true);

  @override
  Future<void> clear() async {
    await setUser(userId: null);
  }

  @override
  Future<void> logEvent<T>({
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

  @override
  Future<void> setUser({String? userId}) async {
    package.Sentry.configureScope(
      (scope) => scope.setUser(package.SentryUser(id: userId)),
    );
  }
}
