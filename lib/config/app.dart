import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fcar_lib/config/enum/app_env.enum.dart';
import 'package:fcar_lib/core/service/localization/localization.provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flavor.dart';
import 'theme/theme.provider.dart';

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

  /// call in the [initState] of the screen of initialRoute
  /// This is where you can initialize the resources needed by your app while
  /// the splash screen is displayed.
  static Future<void> init() async {
    // do add the your code here

    // TODO: remove it later, just for a demo
    // ignore_for_file: avoid_print
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
  }

  /// call before [runApp]
  static Future<void> setup({required AppEnvironment env}) async {
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    themeInitSystemUIOverlayStyle();

    /// setup Analytics
    ///
    // DatadogAnalytics.setup(env: env);
    // FirebaseAnalytics.setup(env: env);
    // SentryAnalytics.setup(env: env);

    /// setup ErrorTracking
    ///
    // DatadogErrorTracking.setup(env: env);
    // FirebaseErrorTracking.setup(env: env);
    // SentryErrorTracking.setup(env: env);

    /// setup PerformanceMonitoring
    ///
    // DatadogPerformanceMonitoring.setup(env: env);
    // FirebasePerformanceMonitoring.setup(env: env);
    // SentryPerformanceMonitoring.setup(env: env);

    /// setup RemoteConfig
    ///
    // FirebaseRemoteConfig.setup(env: AppEnvironment.dev);zzz

    /// setup Notification
    ///
    // RemoteNotification.setup();zzz
    // LocalNotification.setup();zzz

    /// setup Database
    ///
    // DatabaseProvider.setup(names: {
    //   DatabaseType.objectbox: [
    //     DatabaseName.appDb,
    //     DatabaseName.networkCache,
    //   ]
    // });

    await Flavor.setup(env: env);
    await LocalizationProvider.setup();
  }
}
