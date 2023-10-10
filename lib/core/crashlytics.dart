import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crashlytics {
  Crashlytics._();

  static void recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool printDetails = true,
    bool fatal = false,
  }) {
    // if (exception is NetworkException) {
    //   if (exception.response?.statusCode != null) {
    //     final d = exception.response!.statusCode! ~/ 100;
    //     if (d == 4 || d == 5 || exception.isKickout) {
    //       // do not log kickout & 400 & 500 statusCode responses
    //       return;
    //     }
    //   }
    // }

    FirebaseCrashlytics.instance.recordError(
      exception,
      stack,
      reason: reason,
      information: information,
      printDetails: printDetails,
      fatal: fatal,
    );
  }
}
