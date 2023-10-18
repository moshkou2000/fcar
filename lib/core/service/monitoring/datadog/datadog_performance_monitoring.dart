import '../performance_monitoring.dart';
import 'datadog.dart';

class DatadogPerformanceMonitoring extends Datadog
    implements IPerformanceMonitoring {
  static final DatadogPerformanceMonitoring _singleton =
      DatadogPerformanceMonitoring._internal();
  factory DatadogPerformanceMonitoring() => _singleton;
  DatadogPerformanceMonitoring._internal();
}
