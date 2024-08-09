import 'package:fcar_lib/config/enum/app_env.enum.dart';
import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/core/core.module.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'config/constant/asset.constant.dart';
import 'config/flavor.dart';
import 'config/theme/theme.provider.dart';
import 'feature/auth/auth.provider.dart';
import 'feature/shared/empty.view.dart';

@immutable
abstract final class AppProvider {
  static String name = 'F.C.A.R';
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

  /// - This method should not cause a crash
  /// - call in [main] before [runApp]
  /// - Use the ErrorTracking that is used in [App.setup]
  ///   - XXXErrorTracking.recordError
  static void errorHandling() {
    // uncaught sync errors

    /// When widget fails to build
    // ErrorWidget.builder = (FlutterErrorDetails details) {
    //   logger.info('2');
    //   // In debug mode, use the normal error widget
    //   // if (kDebugMode) {
    //   //   return ErrorWidget(details.exception);
    //   // }

    //   // return Scaffold(
    //   //   appBar: AppBar(
    //   //     backgroundColor: Colors.red,
    //   //     title: const Text('An error occurred'),
    //   //   ),
    //   //   body: Center(child: Text(details.toString())),
    //   // );

    //   // // TODO: [EmptyView] may need style
    //   return MaterialApp(
    //     title: App.name,
    //     theme: lightThemeData,
    //     home: EmptyView(
    //       color: Colors.white,
    //       illustration: SvgPicture.asset(
    //         AssetConstant.maintenance,
    //         fit: BoxFit.fitHeight,
    //         alignment: Alignment.center,
    //         width: 200,
    //       ),
    //       title: Localization.error.titleCase,
    //       // TODO: [subtitle] can be localized error description.
    //       // example: 'Contact support!'
    //       subtitle: details.exceptionAsString(),
    //       primaryButtonText: Localization.ok.titleCase,
    //       primaryButtonOnPressed: () {
    //         // TODO: do something
    //         // example: navigate to a screen
    //       },
    //     ),
    //   );
    // };

    /// Flutter error
    FlutterError.onError = (FlutterErrorDetails d) {
      logger.info('1');
      FlutterError.presentError(d);
      logger.info('11');
      // log to console
      FlutterError.dumpErrorToConsole(d);
      // TODO: current one is [FirebaseErrorTracking]
      FirebaseErrorTracking.recordError(
        d.exception,
        d.stack,
        fatal: true,
        reason: 'FlutterError',
      );
      logger.info('111');

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => runApp(
          MaterialApp(
            title: AppProvider.name,
            theme: lightThemeData,
            home: EmptyView(
              color: Colors.white,
              illustration: SvgPicture.asset(
                AssetConstant.maintenance,
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                width: 200,
              ),
              title: Localization.error.titleCase,
              subtitle: 'Localization.error.titleCase',
              primaryButtonText: Localization.apply.titleCase,
            ),
          ),
        ),
      );
    };

    /// PlatformDispatcher error
    PlatformDispatcher.instance.onError = (e, s) {
      // log to console
      logger.error('PlatformDispatcher', e: e, s: s);
      // TODO: current one is [FirebaseErrorTracking]
      FirebaseErrorTracking.recordError(
        e,
        s,
        fatal: true,
        reason: 'PlatformDispatcher',
      );
      return true;
    };
  }

  /// It's better to call in the [initState] of the screen of initialRoute.
  ///
  /// This is where you can initialize the resources needed by your app while
  /// the splash screen is displayed.
  static Future<bool> init(FutureProviderRef ref) async {
    /// init LocalAuth
    ///
    /// Device biometrics (face, fingerprint)
    // LocalAuth.init();

    // <<< do add your code here >>>

    /// init UserAuth
    ///
    await AuthProvider.userAuth(ref: ref);

    return true;
  }

  /// call before [runApp]
  static Future<void> setup({required AppEnvironment env}) async {
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

    // TODO: add try/catch for each service
    // MUST ->>>>>>

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
    // Permissions.request(
    //   Permission.location,
    //   callIfDenied: () {
    //     logger.info('Permission.location Denied.');
    //   },
    //   callIfGranted: () {
    //     logger.info('Permission.location Granted.');
    //   },
    //   callIfPermanentlyDenied: () async {
    //     logger.info('Permission.location Permanently Denied.');
    //     // final isOpened = await Geolocator.openLocationSettings();
    //     // if (!isOpened) await Geolocator.openAppSettings();
    //   },
    // );

    /// setup Notification
    ///
    // RemoteNotification.setup();
    // LocalNotification.setup(defaultIcon: '@drawable/ic_launcher_foreground');

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

    /// setup RemoteAuth
    ///
    /// Microsoft Authorization (Oauth2)
    // RemoteAuth.setup(
    //   clientId: '<Application ID>',
    //   redirectUrl: '<<Bundle ID>://oauth2/client>',
    //   authorizationEndpoint: '<OAuth 2.0 authorization endpoint>',
    //   tokenEndpoint: '<OAuth 2.0 token endpoint>',
    //   scopes: ['openid', 'profile', 'email', 'offline_access'],
    // );

    await Flavor.setup(env: env);
    await LocalizationProvider.setup();
  }
}

final appProvider =
    FutureProvider<bool>((ref) async => await AppProvider.init(ref));
