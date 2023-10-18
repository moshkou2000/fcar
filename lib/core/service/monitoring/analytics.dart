import 'package:flutter/material.dart';

import 'monitoring.enum.dart';

/// All analytics that used as provider must implement [IAnalytics]
/// modify [IAnalytics] based on your need.
abstract class IAnalytics {
  late NavigatorObserver observer;

  Future<void> clear();
  Future<void> setUser({String? userId});
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  });
}
