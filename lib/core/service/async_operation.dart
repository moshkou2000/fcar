import 'dart:async';

import 'package:flutter/foundation.dart';

import '../datasource/network/network_exception.dart';

class AsyncOperation {
  AsyncOperation._();

  static Completer<bool?>? _completer;

  /// Return true if the initialization is successful, otherwise false
  static FutureOr<bool?>? complete({required Future futureTask}) async {
    if (_completer?.isCompleted == false) await _completer?.future;

    _completer = Completer<bool?>();
    try {
      await futureTask;
      _completer?.complete(true);
    } catch (e, s) {
      // unawaited(Crashlytics.recordError(e, s));
      debugPrint('AsyncOperation.complete.error: $e, $s');
      // check if completer alr completed or not, if not, complete it with false value
      if (_completer != null) {
        if (_completer!.isCompleted == false) {
          // when IS NOT cancel and isUnauthorized is true
          if (!(e is NetworkException && (e.isCanceled || e.isUnauthorized))) {
            _completer?.complete(false);
          } else {
            // TODO: might not be needed
            _completer?.complete();
          }
        }
      } else {
        return Future.value(null);
      }
    }

    return _completer?.future ?? Future.value(null);
  }
}
