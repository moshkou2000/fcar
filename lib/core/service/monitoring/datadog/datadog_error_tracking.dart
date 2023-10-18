import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';

import '../../../datasource/network/network_exception.dart';
import '../error_tracking.dart';
import 'datadog.dart';

class DatadogErrorTracking extends Datadog implements IErrorTracking {
  static final DatadogErrorTracking _singleton =
      DatadogErrorTracking._internal();
  factory DatadogErrorTracking() => _singleton;
  DatadogErrorTracking._internal();

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
