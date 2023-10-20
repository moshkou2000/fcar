import 'package:firebase_core/firebase_core.dart' as package;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.dart';

@immutable
abstract final class Firebase {
  static Future<void> init({required AppEnvironment env}) async {
    await package.Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
