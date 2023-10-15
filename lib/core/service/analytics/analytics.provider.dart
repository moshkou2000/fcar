import 'analytics.dart';
import 'datadog/datadog.dart';
import 'firebase/firebase.dart';
import 'sentry/sentry.dart';

// TODO: use riverpod
final analyticsProvider = AnalyticsProvider();

class AnalyticsProvider {
  late final IAnalytics analytics;

  AnalyticsProvider() {
    _createFirebaseAnalytics();
    // _createDatadogAnalytics();
    // _createSentryAnalytics();
  }

  void _createFirebaseAnalytics() {
    analytics = Firebase();
  }

  void _createDatadogAnalytics() {
    analytics = Datadog();
  }

  void _createSentryAnalytics() {
    analytics = Sentry();
  }
}
