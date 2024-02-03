import 'dart:async';

import 'package:fcar_lib/config/enum/app_env.enum.dart';
import 'package:fcar_lib/core/service/monitoring/error_tracking/firebase_error_tracking.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'app.provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppProvider.errorHandling();
    await AppProvider.setup(env: AppEnvironment.fromString(appFlavor));
    runApp(const ProviderScope(child: App()));
  }, (e, s) {
    logger.error('runZonedGuarded', e: e, s: s);

    // Use [ErrorTracking] which is used in App.setup
    FirebaseErrorTracking.recordError(
      e,
      s,
      fatal: true,
      reason: 'runZonedGuarded',
    );
  });
}
