import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.dart';
import 'datadog.dart';

@immutable
abstract final class PerformanceMonitoring {
  static init({required AppEnvironment env}) => Datadog.init(env: env);
}
