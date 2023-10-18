import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../datasource/network/network_exception.dart';
import '../error_tracking.dart';

class FirebaseErrorTracking implements IErrorTracking {
  static final FirebaseErrorTracking _singleton =
      FirebaseErrorTracking._internal();
  factory FirebaseErrorTracking() => _singleton;
  FirebaseErrorTracking._internal();

  @override
  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {},
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

    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: reason,
      information: information.keys.map((e) => '$e:${information[e]}'),
      printDetails: printDetails,
      fatal: fatal,
    );
  }
}
