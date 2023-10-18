import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../../config/enum/app_env.dart';

abstract class Firebase {
  Future<void> init({required AppEnvironment env}) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
