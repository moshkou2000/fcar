import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../../../datasource/network/network_exception.dart';
import '../error_tracking.dart';
import 'sentry.dart';

class SentryErrorTracking extends Sentry implements IErrorTracking {
  static final SentryErrorTracking _singleton = SentryErrorTracking._internal();
  factory SentryErrorTracking() => _singleton;
  SentryErrorTracking._internal();

  @override
  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {}, //Iterable<Object>
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (filter) {
      if (exception is NetworkException && exception.skipLogging) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    // TODO: use only one of the following

    // error tracking and performance monitoring

    package.Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: package.Hint.withMap(Map<String, Object>.from(information)),
    );
  }
}
