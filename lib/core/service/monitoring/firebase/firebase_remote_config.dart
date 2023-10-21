import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../feature/shared/dialog/dialog.dart';

@immutable
abstract final class RemoteConfig {
  static const String _lVersion = 'lowest_version';
  static const String _dUrl = 'download_url';

  String get _lowestVersion =>
      FirebaseRemoteConfig.instance.getString(_lVersion);
  String get _downloadUrl => FirebaseRemoteConfig.instance.getString(_dUrl);

  String getRemoteConfigValue({required String key}) =>
      FirebaseRemoteConfig.instance.getString(_dUrl);

  Future<void> init({
    Map<String, dynamic>? defaultParameters,
  }) async {
    try {
      final params = defaultParameters ??
          <String, dynamic>{
            _lVersion: '',
            _dUrl: '',
          };
      await FirebaseRemoteConfig.instance.setDefaults(params);
      await FirebaseRemoteConfig.instance.fetchAndActivate();
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
      final int count = min(lowestVersions.length, currentVersions.length);
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
