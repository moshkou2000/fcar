import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/datasource/database/database.enum.dart';
import '../core/datasource/database.provider.dart';
import '../core/service/localization/localization.dart';
import '../core/service/monitoring/error_tracking.module.dart';
import '../core/service/notification/notification.module.dart';
import '../core/service/notification/remote/firebase_messaging.dart';
import 'enum/app_env.dart';
import '../core/service/localization/localization_dictionary.dart';
import 'flavor.dart';

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

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // ErrorTracking.setup(env: env);
    // Analytics.setup(env: env);
    // PerformanceMonitoring.setup(env: env);
    // RemoteNotification.setup();
    // LocalNotification.setup();
    // DatabaseProvider.setup(names: {
    //   DatabaseType.objectbox: [
    //     DatabaseName.appDb,
    //     DatabaseName.networkCache,
    //   ]
    // });
    await Flavor.setup(env: env);
    await Localization.setup();
  }
}
