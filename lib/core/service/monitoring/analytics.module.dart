/// Reference to the given analytics dataset
/// export only one
///
// export 'datadog/datadog_analytics.dart';
// export 'firebase/firebase_analytics.dart';
export 'sentry/sentry_analytics.dart';

/// each [*_analytics.dart] must implement the [Analytics]
/// duplicate the code and complete the functions body.
///
/// @immutable
/// final class Analytics {
///   static init({required AppEnvironment env}) {...}
///   static Future<void> clear() async {...}
///     static Future<void> logEvent<T>({
///     required AnalyticsEvent event,
///     Map<String, dynamic>? data,
///   }) async {...}
///   static Future<void> setUser({String? userId}) {...}
/// }
