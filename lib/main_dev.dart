import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app.dart';
import 'config/enum/app_env.dart';
import 'core/service/crashlytics/crashlytics.dart';
import 'main.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      Crashlytics.recordError(
        details.exception,
        details.stack,
        fatal: true,
        reason: 'FlutterError',
      );
      originalOnError?.call(details);
    };
    PlatformDispatcher.instance.onError = (e, s) {
      Crashlytics.recordError(
        e,
        s,
        fatal: true,
        reason: 'PlatformDispatcher',
      );
      return true;
    };

    await App.setup(env: AppEnvironment.dev);

    runApp(const ProviderScope(child: MyApp()));
  }, (e, s) {
    Crashlytics.recordError(
      e,
      s,
      fatal: true,
      reason: 'runZonedGuarded',
    );
  });
}
