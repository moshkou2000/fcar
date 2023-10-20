import 'package:firebase_analytics/firebase_analytics.dart';

final class NavigationObserver extends FirebaseAnalyticsObserver {
  NavigationObserver() : super(analytics: FirebaseAnalytics.instance);
}
