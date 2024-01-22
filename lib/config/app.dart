import 'package:fcar_lib/config/enum/app_env.enum.dart';
import 'package:fcar_lib/core/service/auth/remote/oauth2.dart';
import 'package:fcar_lib/core/service/geolocator/geolocator.module.dart';
import 'package:fcar_lib/core/service/localization/localization.provider.dart';
import 'package:fcar_lib/core/service/permission/permissions.module.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'flavor.dart';
import 'theme/theme.provider.dart';

class App {
  static String name = 'FCAR';
  static String os = '';
  static String osVersion = '';
  static String id = '';
  static String version = '';
  static String buildNumber = '';

  static void clear() {
    name = '';
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

  /// It's better to call in the [initState] of the screen of initialRoute.
  ///
  /// This is where you can initialize the resources needed by your app while
  /// the splash screen is displayed.
  static Future<void> init() async {
    // do add the your code here
  }

  /// call before [runApp]
  static Future<void> setup({required AppEnvironment env}) async {
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

    /// setup the Device Orientation
    ///
    await deviceOrientation();

    /// setup the System Overlay
    ///
    themeInitSystemUIOverlayStyle();
    systemOverlaysChangeCallback();
    await hideOverlays();

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

    /// setup Analytics
    ///
    // DatadogAnalytics.setup(env: env);
    // FirebaseAnalytics.setup(env: env);
    // SentryAnalytics.setup(env: env);

    /// setup RemoteConfig
    ///
    // FirebaseRemoteConfig.setup(env: AppEnvironment.dev);

    /// setup Permissions
    ///
    Permissions.request(
      Permission.location,
      callIfDenied: () {
        logger.info('Permission.location Denied.');
      },
      callIfGranted: () {
        logger.info('Permission.location Granted.');
      },
      callIfPermanentlyDenied: () async {
        logger.info('Permission.location Permanently Denied.');
        final isOpened = await Geolocators.geolocator.openLocationSettings();
        if (!isOpened) await Geolocators.geolocator.openAppSettings();
      },
    );

    /// setup Notification
    ///
    // RemoteNotification.setup();
    // LocalNotification.setup();

    /// setup Database
    ///
    // DatabaseProvider.setup(names: {
    //   DatabaseType.objectbox: [
    //     DatabaseName.appDb,
    //     DatabaseName.networkCache,
    //   ]
    // });

    /*
      Terms and Conditions: url
      Privacy Policy: url

      Name: timesheet-mobile-dev
      Display name: Timesheet Mobile (dev)
      Bundle ID: 
      Redirect URI: <Bundle ID>://oauth2/client
      Tenant ID: 
      Application (client) ID: 
      Client identifier: 
      Client secret: <optional>

      > Microsoft Authorization endpoint
      https://login.microsoftonline.com

      > OAuth 2.0 authorization endpoint (v2)
      https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize
      https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/authorize

      > OAuth 2.0 token endpoint (v2)
      https://login.microsoftonline.com/organizations/oauth2/v2.0/token
      https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token

      > Microsoft Graph API endpoint
      https://graph.microsoft.com
    */

    /// setup Authorization
    ///
    /// Microsoft Authorization (Oauth2)
    Oauth2.setup(
      authorizationEndpoint: Uri.parse(''),
      tokenEndpoint: Uri.parse(''),
      redirectUrl: Uri.parse(''),
      identifier: '',
      secret: null,
      redirect: (Uri url) async {},
      listen: (Uri url) async {
        return Uri();
      },
      jsonCredentials: '',
    );

    await Flavor.setup(env: env);
    await LocalizationProvider.setup();
  }
}
