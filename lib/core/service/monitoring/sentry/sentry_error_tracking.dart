import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../../../../config/enum/app_env.dart';
import '../../../datasource/network/network_exception.dart';
import 'sentry.dart';

// error tracking and performance monitoring

@immutable
abstract final class ErrorTracking {
  static Future<void> setup({required AppEnvironment env}) async {
    Sentry.init(env: env);
  }

  static void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {}, //Iterable<Object>
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (filter) {
      if (exception is NetworkException) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    package.Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: package.Hint.withMap(Map<String, Object>.from(information)),
    );
  }
}
