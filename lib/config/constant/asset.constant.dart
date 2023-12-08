import 'package:flutter/material.dart';

@immutable
abstract final class AssetConstant {
// path
  static const String assetPath = 'asset';
  static const String iconPath = '$assetPath/icon';
  static const String illustrationPath = '$assetPath/illustration';
  static const String imagePath = '$assetPath/image';

// icon
  static const String sunCloudIcon = '$iconPath/sun_cloud.svg';

// image
  static const String calendarImage = '$imagePath/calendar.png';

// illustration
  static const String emptyStates = '$illustrationPath/empty_states.svg';
  static const String forbidden = '$illustrationPath/forbidden.svg';
  static const String informational = '$illustrationPath/informational.svg';
  static const String maintenance = '$illustrationPath/maintenance.svg';
  static const String noAccess = '$illustrationPath/no_access.svg';
  static const String noConnection = '$illustrationPath/no_connection.svg';
  static const String noData = '$illustrationPath/no_data.svg';
  static const String noEvent = '$illustrationPath/no_event.svg';
  static const String noTask = '$illustrationPath/no_task.svg';
  static const String search = '$illustrationPath/search.svg';
  static const String setup = '$illustrationPath/setup.svg';
}
