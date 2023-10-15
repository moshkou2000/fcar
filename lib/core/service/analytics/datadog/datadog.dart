import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';

import '../../../../config/constant/env.constant.dart';
import '../../../../config/enum/app_env.dart';
import '../../../datasource/network/network_exception.dart';
import '../analytics.dart';
import '../analytics.enum.dart';

class Datadog implements IAnalytics {
  @override
  NavigatorObserver observer =
      DatadogNavigationObserver(datadogSdk: DatadogSdk.instance);

  @override
  Future<void> clear() async {
    await setUser(userId: null);
  }

  // When the app is in the background and opened directly from the push notification.
  @override
  Future<void> init({required AppEnvironment env}) async {
    DatadogSdk.instance.sdkVerbosity = Verbosity.verbose;
    await DatadogSdk.instance.initialize(DdSdkConfiguration(
      clientToken: EnvConstant.datadogClientToken,
      env: AppEnvironment.uat.name,
      site: DatadogSite.us1,
      trackingConsent: TrackingConsent.granted,
      nativeCrashReportEnabled: true,
      loggingConfiguration: LoggingConfiguration(),
      rumConfiguration: RumConfiguration(
        applicationId: EnvConstant.datadogApplicationId,
      ),
    ));
  }

  @override
  Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    // logEvent(eventName: eventName, data: data);
    DatadogSdk.instance.logs?.info(
      event.name,
      attributes: data != null ? Map<String, Object?>.from(data) : {},
    );
  }

  @override
  Future<void> setUser({String? userId}) async {
    DatadogSdk.instance.setUserInfo(id: userId);
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

    DatadogSdk.instance.rum?.addError(
      exception,
      RumErrorSource.source,
      stackTrace: stackTrace,
      errorType: exception.runtimeType.toString(),
      attributes: information,
    );
  }
}
