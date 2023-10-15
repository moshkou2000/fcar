import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../../../config/enum/app_env.dart';
import '../../../datasource/network/network_exception.dart';
import '../analytics.dart';
import '../analytics.enum.dart';

class Firebase implements IAnalytics {
  @override
  NavigatorObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  Future<void> clear() async {
    await setUser(userId: null);
  }

  @override
  Future<void> init({required AppEnvironment env}) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  @override
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    FirebaseAnalytics.instance.logEvent(name: event.name, parameters: data);
  }

  @override
  Future<void> setUser({String? userId}) async {
    FirebaseAnalytics.instance.setUserId(id: userId);
  }

  @override
  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {},
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (filter) {
      if (exception is NetworkException && exception.skipLogging) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    // TODO: use only one of the following

    // error tracking and performance monitoring

    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: reason,
      information: information.keys.map((e) => '$e:${information[e]}'),
      printDetails: printDetails,
      fatal: fatal,
    );
  }
}
