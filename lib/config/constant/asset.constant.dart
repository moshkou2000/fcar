import 'package:flutter/material.dart';

@immutable
abstract final class AssetConstant {
// path
  static const String assetPath = 'asset';
  static const String iconPath = '$assetPath/icon';
  static const String imagePath = '$assetPath/image';

// icon
  static const String sunCloudIcon = '$iconPath/sun_cloud.png';

// image
  static const String calendarImage = '$imagePath/calendar.png';
}
