import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.dart';
import 'sentry.dart';

@immutable
abstract final class PerformanceMonitoring {
  static init({required AppEnvironment env}) => Sentry.init(env: env);
}
