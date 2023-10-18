import 'package:firebase_analytics/firebase_analytics.dart' as firebase;
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

import '../analytics.dart';
import '../monitoring.enum.dart';

class FirebaseAnalytics implements IAnalytics {
  static final FirebaseAnalytics _singleton = FirebaseAnalytics._internal();
  factory FirebaseAnalytics() => _singleton;
  FirebaseAnalytics._internal();

  @override
  NavigatorObserver observer =
      FirebaseAnalyticsObserver(analytics: firebase.FirebaseAnalytics.instance);

  @override
  Future<void> clear() async {
    await setUser(userId: null);
  }

  @override
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    firebase.FirebaseAnalytics.instance
        .logEvent(name: event.name, parameters: data);
  }

  @override
  Future<void> setUser({String? userId}) async {
    firebase.FirebaseAnalytics.instance.setUserId(id: userId);
  }
}
