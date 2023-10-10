import 'package:firebase_analytics/firebase_analytics.dart';

import '../analytics.dart';

class Firebase implements IAnalytics {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Future<void> logEvent<T>({
    required String eventName,
    Map<String, dynamic>? data,
  }) async {
    _analytics.logEvent(name: eventName, parameters: data);
  }

  @override
  Future<void> setUser({String? userId}) async {
    _analytics.setUserId(id: userId);
  }
}
