import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/config/enum/app_env.enum.dart';
import 'package:fcar_lib/core/service/monitoring/error_tracking/firebase_error_tracking.dart';

import 'config/app.dart';
import 'config/constant/asset.constant.dart';
import 'core/service/localization/localization.dart';
import 'feature/shared/shared.module.dart';
import 'main.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      FlutterError.dumpErrorToConsole(details);
      FlutterError.presentError(details);
      FirebaseErrorTracking.recordError(
        details.exception,
        details.stack,
        fatal: true,
        reason: 'FlutterError',
      );
      originalOnError?.call(details);
      runApp(ProviderScope(
        child: MaterialApp(
          home: EmptyView(
            color: Colors.white,
            illustration: SvgPicture.asset(
              AssetConstant.maintenance,
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              width: 200,
            ),
            title: Localization.error.titleCase,
            subtitle: Localization.error.titleCase,
            primaryButtonText: Localization.apply.titleCase,
            secondaryButtonText: Localization.cancel.titleCase,
          ),
        ),
      ));
    };
    PlatformDispatcher.instance.onError = (e, s) {
      FirebaseErrorTracking.recordError(
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
    FirebaseErrorTracking.recordError(
      e,
      s,
      fatal: true,
      reason: 'runZonedGuarded',
    );
  });
}
