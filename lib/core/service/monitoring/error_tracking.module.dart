/// Reference to the given error tracking dataset
/// export only one
// export 'datadog/datadog_error_tracking.dart';
// export 'firebase/firebase_error_tracking.dart';
export 'sentry/sentry_error_tracking.dart';

/// each [*_error_tracking.dart] must implement the [ErrorTracking]
/// duplicate the code and complete the functions body.
///
/// @immutable
/// final class ErrorTracking {
///   static Future<void> setup({required AppEnvironment env}) async {
///   static void recordError(
///     dynamic exception,
///     StackTrace? stackTrace, {
///     dynamic reason,
///     Map<String, dynamic> information = const {}, //Iterable<Object>
///     bool printDetails = true,
///     bool fatal = false,
///     bool filter = true,
///   }) {...}
/// }