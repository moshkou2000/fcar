import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ServiceImpl {
  @override
  Future<void> appInit({
    Role? role,
    String? token,
    String? username,
    int? userId,
  }) async {
    analytics.init();
    final deployCountry = await _appLibsPreferences.getCountrySelected();
    App.setCountry(deployCountry: deployCountry);
    await userService.init(
      user: User(
        id: userId,
        role: role,
        token: token,
        username: username,
      ),
    );
    await App.init(token: userService.token);

    if (userService.isLogin) {
      if (!FlavorManager.instance.isDev) {
        await FirebaseCrashlytics.instance
            .setUserIdentifier(userService.id?.toString() ?? 'Unknown');
        await analytics.setAmplitudeUserId(userId: userService.id?.toString());
      }

      await initializeDateFormatting();
      await initPhotoPath(); // TODO: delete once we no longer need the legacy image picker

      try {
        await versionControlService.init();
      } catch (e, s) {
        debugPrint(e.toString());
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, s, reason: 'appInit -> versionControlService'));
      }

      try {
        await templateService.init();
        await inspectionFlowService.init();
      } catch (e, s) {
        debugPrint(e.toString());
        Crashlytics.recordError(
          e,
          s,
          reason: 'appInit -> checkTemplate & getInspectionFlow',
        );
      }

      try {
        /// init new inspection when there is ongoing inspection
        /// [hasOnGoingInspection == true]
        /// it's to save data to db in the init.
        await onGoingInspectionService.init(
          newOngoingInspection: false,
          hasOnGoingInspection: true,
        );
      } catch (e, s) {
        debugPrint(e.toString());
        Crashlytics.recordError(
          e,
          s,
          reason: 'appInit -> onGoingInspection',
        );
      }

      try {
        await notificationService.requestNotificationPermission();
        await notificationService.configureNotification();
        await notificationService.uploadFcmTokenToNotificationMs();
        await fcmService.getInitialMessage();
      } catch (e, s) {
        debugPrint(e.toString());
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, s, reason: 'appInit -> notification'));
      }
      try {
        unawaited(
            carLibService.downloadCarLib(context: null, showDialog: false));
      } catch (e, s) {
        debugPrint(e.toString());
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, s, reason: 'appInit -> downloadCarLib'));
      }
    }
  }

  @override
  void cancelApiRequests() {
    NetworkCancelToken.cancelGetCarLib();
  }

  @override
  Future<List<Remark>> getRemarks({required int leadId}) async {
    final List<RemarkDto> result = await network.getRemarks(leadId: leadId);
    return result.map((e) => Remark.fromDto(e)).toList();
  }

  @override
  Future<void> logout() async {
    await keystore.clearSession();
    App.clear();
    userService.clear();
    NetworkCancelToken.cancelGetCarLib();
    // TODO: clean user data from db
    // await _databaseService.clearAccessories();
    await analytics.setAmplitudeUserId(userId: null);
    Future.delayed(
        const Duration(milliseconds: 100),
        () async =>
            await navigationService.pushAndRemoveUntil(ConstantNav.loginRoute));
  }
}
