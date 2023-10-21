import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../feature/shared/dialog/dialog.dart';

final RemoteConfigService remoteConfigService = RemoteConfigService();

class RemoteConfigService {
  static const String _lVersion = 'lowest_version';
  static const String _dUrl = 'download_url';
  static late final FirebaseRemoteConfig _remoteConfig;

  String get _lowestVersion => _remoteConfig.getString(_lVersion);
  String get _downloadUrl => _remoteConfig.getString(_dUrl);
  String getRemoteConfigValue({required String key}) =>
      _remoteConfig.getString(_dUrl);

  RemoteConfigService() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<void> init({
    Map<String, dynamic>? defaultParameters,
  }) async {
    try {
      final params = defaultParameters ??
          <String, dynamic>{
            _lVersion: '',
            _dUrl: '',
          };
      await _remoteConfig.setDefaults(params);
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> versionControl({
    required String currentVersion,
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
  }) async {
    await init();
    if (context.mounted) {
      if (_isBiggerVersion(currentVersion)) {
        showDialogAt(
            context: context,
            title: title,
            subtitle: message,
            barrierDismissible: false,
            primaryActionText: buttonText,
            onPrimaryActionPressed: (_) => _launchUrl(_downloadUrl));
        return true;
      }
    }
    if (kDebugMode) {
      print(context.mounted);
    }
    return false;
  }

  bool _isBiggerVersion(String currentVersion) {
    if (_lowestVersion.isEmpty == true || currentVersion.isEmpty == true) {
      return false;
    }
    try {
      var lowestVersions = _lowestVersion.split('.');
      if (lowestVersions.isEmpty == true) {
        lowestVersions = [_lowestVersion];
      }
      var currentVersions = currentVersion.split('.');
      if (currentVersions.isEmpty == true) {
        currentVersions = [currentVersion];
      }
      final int count = math.min(lowestVersions.length, currentVersions.length);
      for (var i = 0; i < count; i++) {
        final lowVersion = int.parse(lowestVersions[i]);
        final currVersion = int.parse(currentVersions[i]);
        if (lowVersion != currVersion) {
          return lowVersion > currVersion;
        } else if (i == count - 1 &&
            lowestVersions.length > currentVersions.length &&
            int.parse(lowestVersions[i + 1]) > 0) {
          return true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(Uri.encodeFull(url));
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        try {
          await launchUrl(uri);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
  }
}
