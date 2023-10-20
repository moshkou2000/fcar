import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.dart';
import 'firebase.dart';

@immutable
abstract final class PerformanceMonitoring {
  static init({required AppEnvironment env}) => Firebase.init(env: env);
}
