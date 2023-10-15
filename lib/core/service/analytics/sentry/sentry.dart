import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../../../../config/constant/env.constant.dart';
import '../../../../config/enum/app_env.dart';
import '../../../datasource/network/network_exception.dart';
import '../analytics.dart';
import '../analytics.enum.dart';

class Sentry implements IAnalytics {
  @override
  NavigatorObserver observer =
      package.SentryNavigatorObserver(setRouteNameAsTransaction: true);

  get packageHint => null;

  @override
  Future<void> clear() async {
    await setUser(userId: null);
  }

  // When the app is in the background and opened directly from the push notification.
  @override
  Future<void> init({required AppEnvironment env}) async {
    await package.SentryFlutter.init((options) {
      // options.addInAppInclude('sentry_flutter_example');
      options.attachScreenshot = false;
      options.attachThreads = true;
      options.attachViewHierarchy = true;
      options.considerInAppFramesByDefault = false;
      options.debug = false;
      // options.diagnosticLevel = SentryLevel.error;
      options.dsn = EnvConstant.sentryDsn;
      options.enableWindowMetricBreadcrumbs = true;
      options.environment = env.name;
      options.maxRequestBodySize = package.MaxRequestBodySize.always;
      options.maxResponseBodySize = package.MaxResponseBodySize.always;
      options.reportPackages = false;
      options.reportSilentFlutterErrors = true;
      options.screenshotQuality = package.SentryScreenshotQuality.low;
      options.sendDefaultPii = false;
      options.tracesSampleRate = 1.0;
    });
  }

  @override
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    // logEvent(eventName: eventName, data: data);
    package.Sentry.captureMessage(
      event.name,
      level: package.SentryLevel.info,
      params: data?.keys.map((e) => '$e:${data[e]}').toList(),
      hint: data != null
          ? package.Hint.withMap(Map<String, Object>.from(data))
          : null,
    );
  }

  @override
  Future<void> setUser({String? userId}) async {
    package.Sentry.configureScope(
      (scope) => scope.setUser(package.SentryUser(id: userId)),
    );
  }

  @override
  void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {}, //Iterable<Object>
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (filter) {
      if (exception is NetworkException && exception.skipLogging) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    // TODO: use only one of the following

    // error tracking and performance monitoring

    package.Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: packageHint.withMap(Map<String, Object>.from(information)),
    );
  }
}
