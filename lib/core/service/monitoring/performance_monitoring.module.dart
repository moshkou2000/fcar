/// Reference to the given performance monitoring dataset
/// export only one
// export 'datadog/datadog_performance_monitoring.dart';
// export 'firebase/firebase_performance_monitoring.dart';
export 'sentry/sentry_performance_monitoring.dart';

/// each [*_performance_monitoring.dart] must implement the [PerformanceMonitoring]
/// duplicate the code and complete the functions body.
///
/// @immutable
/// final class PerformanceMonitoring {
///   static init({required AppEnvironment env}) {...}
/// }
