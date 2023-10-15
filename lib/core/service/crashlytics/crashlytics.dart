import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../datasource/network/network_exception.dart';

/// No recordError filering when [filter] is false
///
class Crashlytics {
  static void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {}, //Iterable<Object>
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    /// skip in the folowing condition
    ///
    if (filter) {
      if (exception is NetworkException) {
        if (exception.response?.statusCode != null) {
          final d = exception.response!.statusCode! ~/ 100;
          if (d == 4 || d == 5 || exception.isUnauthorized) {
            // do not log kickout & 400 & 500 statusCode responses
            return;
          }
        }
      }
    }

    // TODO: use only one of the following

    // error tracking and performance monitoring

    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: reason,
      information: information.keys.map((e) => '$e:${information[e]}'),
      printDetails: printDetails,
      fatal: fatal,
    );

    DatadogSdk.instance.rum?.addError(
      exception,
      RumErrorSource.source,
      stackTrace: stackTrace,
      errorType: exception.runtimeType.toString(),
      attributes: information,
    );

    Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: Hint.withMap(Map<String, Object>.from(information)),
    );
  }
}
