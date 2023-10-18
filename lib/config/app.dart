import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/datasource/database/database.enum.dart';
import '../core/datasource/database/database.provider.dart';
import '../core/service/navigation.service.dart';
import '../core/service/notification/remote/firebase_messaging.dart';
import '../core/service/monitoring/monitoring.provider.dart';
import 'constant/nav.constant.dart';
import 'enum/app_env.dart';
import '../shared/domain/provider/localization/localization.service.dart';
import '../core/flavor/flavor.service.dart';

class App {
  static String os = '';
  static String osVersion = '';
  static String id = '';
  static String version = '';
  static String buildNumber = '';

  static void clear() {
    os = '';
    osVersion = '';
    id = '';
    version = '';
    buildNumber = '';
  }

  // static Future<void> init({
  //   String? token,
  // }) async {
  //   final Map<String, String> packageInfo =
  //       await DeviceInfoService.getPackageInfo();
  //
  //   // network config
  //   // populate API header
  //   Api.headers.addAll(packageInfo);
  //   Api.headers.addAll({
  //     HttpHeaders.authorizationHeader: token,
  //     HttpHeaders.contentTypeHeader: Api.jsonContentType,
  //   });
  //
  //   os = packageInfo['APP_ID'] ?? '';
  //   osVersion = packageInfo['APP_OS'] ?? '';
  //   id = packageInfo['APP_OS_VERSION'] ?? '';
  //   version = packageInfo['APP_VERSION'] ?? '';
  //   buildNumber = packageInfo['APP_BUILD_NUMBER'] ?? '';
  // }

  static Future<void> setup({required AppEnvironment env}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // TODO: setup from the provider
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // TODO: setup from the provider, like this one
    FirebaseMessagingService.setup();

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    FlavorService(env: env);
    await FlavorService.setFlavor();

    await localizationService.init();

    // TODO: setup analytics / error tracking / performance monitoring
    // do it here

    DatabaseProvider.createDatabase(names: {
      DatabaseType.objectbox: [DatabaseName.appDb, DatabaseName.networkCache]
    });
  }
}
