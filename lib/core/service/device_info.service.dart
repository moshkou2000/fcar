import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../config/constant/value.constant.dart';

final Provider<DeviceInfoService> deviceInfoService =
    Provider<DeviceInfoService>((_) => DeviceInfoService());

class DeviceInfoService {
  static final DeviceInfoService _singleton = DeviceInfoService._internal();
  factory DeviceInfoService() => _singleton;
  DeviceInfoService._internal();

  Future<Map<String, String>> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'APP_ID': packageInfo.packageName,
      'APP_VERSION': packageInfo.version,
      'APP_BUILD_NUMBER': packageInfo.buildNumber,
      'OS': Platform.isIOS ? ValueConstant.ios : ValueConstant.android,
      'OS_VERSION': Platform.operatingSystemVersion,
    };
  }

  Future<AndroidDeviceInfo> getAndroidInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.androidInfo;
  }

  Future<IosDeviceInfo> getIosInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.iosInfo;
  }

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      final info = await getIosInfo();
      return <String, dynamic>{
        'App Version': '${packageInfo.version} (${packageInfo.buildNumber})',
        'identifierForVendor': info.identifierForVendor,
        'isPhysicalDevice': info.isPhysicalDevice,
        'localizedModel': info.localizedModel,
        'model': info.model,
        'name': info.name,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'utsname.machine:': info.utsname.machine,
        'utsname.nodename:': info.utsname.nodename,
        'utsname.release:': info.utsname.release,
        'utsname.sysname:': info.utsname.sysname,
        'utsname.version:': info.utsname.version,
      };
    }

    final info = await getAndroidInfo();
    return <String, dynamic>{
      'App Version': '${packageInfo.version} (${packageInfo.buildNumber})',
      'board': info.board,
      'bootloader': info.bootloader,
      'brand': info.brand,
      'device': info.device,
      'display': info.display,
      'fingerprint': info.fingerprint,
      'hardware': info.hardware,
      'host': info.host,
      'id': info.id,
      'isPhysicalDevice': info.isPhysicalDevice,
      'manufacturer': info.manufacturer,
      'model': info.model,
      'product': info.product,
      'tags': info.tags,
      'type': info.type,
      'supported32BitAbis': info.supported32BitAbis,
      'supported64BitAbis': info.supported64BitAbis,
      'supportedAbis': info.supportedAbis,
      'version.baseOS': info.version.baseOS,
      'version.codename': info.version.codename,
      'version.incremental': info.version.incremental,
      'version.previewSdkInt': info.version.previewSdkInt,
      'version.release': info.version.release,
      'version.securityPatch': info.version.securityPatch,
      'version.sdkInt': info.version.sdkInt,
    };
  }
}
