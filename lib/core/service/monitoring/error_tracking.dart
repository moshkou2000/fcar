import 'package:flutter/material.dart';

import '../../../config/enum/app_env.dart';

/// All monitoring that used as provider must implement [IErrorTracking]
/// modify [IErrorTracking] based on your need.
abstract class IErrorTracking {
  // late NavigatorObserver observer;

  // Future<void> init({required AppEnvironment env});
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
