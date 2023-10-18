import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';

import '../analytics.dart';
import '../monitoring.enum.dart';
import 'datadog.dart';

class DatadogAnalytics extends Datadog implements IAnalytics {
  static final DatadogAnalytics _singleton = DatadogAnalytics._internal();
  factory DatadogAnalytics() => _singleton;
  DatadogAnalytics._internal();

  @override
  NavigatorObserver observer =
      DatadogNavigationObserver(datadogSdk: DatadogSdk.instance);

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
    DatadogSdk.instance.logs?.info(
      event.name,
      attributes: data != null ? Map<String, Object?>.from(data) : {},
    );
  }

  @override
  Future<void> setUser({String? userId}) async {
    DatadogSdk.instance.setUserInfo(id: userId);
  }
}
