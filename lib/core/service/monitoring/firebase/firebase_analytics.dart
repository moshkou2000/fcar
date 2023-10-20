import 'package:firebase_analytics/firebase_analytics.dart' as package;
import 'package:flutter/material.dart';

import '../../../../config/enum/app_env.dart';
import '../monitoring.enum.dart';
import 'firebase.dart';

@immutable
abstract final class Analytics {
  static init({required AppEnvironment env}) => Firebase.init(env: env);

  Future<void> clear() async {
    await setUser(userId: null);
  }

  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    package.FirebaseAnalytics.instance
        .logEvent(name: event.name, parameters: data);
  }

  Future<void> setUser({String? userId}) async {
    package.FirebaseAnalytics.instance.setUserId(id: userId);
  }
}
