import 'package:flutter/material.dart';

import '../../../config/enum/app_env.dart';
import 'analytics.enum.dart';

/// All analytics that used as provider must implement [IAnalytics]
/// modify [IAnalytics] based on your need.
abstract class IAnalytics {
  late NavigatorObserver observer;

  Future<void> clear();
  Future<void> init({required AppEnvironment env});
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  });
  Future<void> setUser({String? userId});
  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {},
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {}
}
