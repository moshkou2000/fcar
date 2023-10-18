import '../performance_monitoring.dart';
import 'sentry.dart';

class SentryPerformanceMonitoring extends Sentry
    implements IPerformanceMonitoring {
  static final SentryPerformanceMonitoring _singleton =
      SentryPerformanceMonitoring._internal();
  factory SentryPerformanceMonitoring() => _singleton;
  SentryPerformanceMonitoring._internal();
}
