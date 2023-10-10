import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:inspector/constant/app.dart';
import 'package:inspector/constant/crashlytics.constant.dart';
import 'package:inspector/constant/enum/role_arrival_type.dart';
import 'package:inspector/constant/enum/user_role.dart';
import 'package:inspector/constant/nav.constant.dart';
import 'package:inspector/core/application/analytics.service.dart';
import 'package:inspector/core/application/car_lib.service.dart';
import 'package:inspector/core/application/device_info.service.dart';
import 'package:inspector/core/application/fcm.service.dart';
import 'package:inspector/core/application/inspection_flow/inspection_flow.service.dart';
import 'package:inspector/core/application/navigation.service.dart';
import 'package:inspector/core/application/notification.service.dart';
import 'package:inspector/core/application/ongoing_inspection/ongoing_inspection.service.dart';
import 'package:inspector/core/application/template.service.dart';
import 'package:inspector/core/application/user.service.dart';
import 'package:inspector/core/application/version_control.service.dart';
import 'package:inspector/core/data/dto/bidding_history.dto.dart';
import 'package:inspector/core/data/dto/buyer.dto.dart';
import 'package:inspector/core/data/dto/inspection_item.dto.dart';
import 'package:inspector/core/data/dto/inspection_summary.dto.dart';
import 'package:inspector/core/data/dto/inspector.dto.dart';
import 'package:inspector/core/data/dto/remark.dto.dart';
import 'package:inspector/core/data/dto/slot.dto.dart';
import 'package:inspector/core/data/dto/user.dto.dart';
import 'package:inspector/core/data/repository/database/database.repository.dart';
import 'package:inspector/core/data/repository/keystore/keystore.repository.dart';
import 'package:inspector/core/data/repository/network/network.repository.dart';
import 'package:inspector/core/data/repository/network/network_cancel_token.dart';
import 'package:inspector/core/domain/model/bidding_history.dart';
import 'package:inspector/core/domain/model/buyer.dart';
import 'package:inspector/core/domain/model/flavor_manager.dart';
import 'package:inspector/core/domain/model/inspection_item.dart';
import 'package:inspector/core/domain/model/inspection_summary.dart';
import 'package:inspector/core/domain/model/inspector.dart';
import 'package:inspector/core/domain/model/item.dart';
import 'package:inspector/core/domain/model/metadata.dart';
import 'package:inspector/core/domain/model/remark.dart';
import 'package:inspector/core/domain/model/slot.dart';
import 'package:inspector/core/domain/model/user.dart';
import 'package:inspector/ui/shared/legacy_widget/image_picker/utils/photo_path.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:v4_app_libs/v4_app_libs.dart';

abstract class Service {
  // a
  Future<void> appInit({
    Role? role,
    String? token,
    String? username,
    int? userId,
  });
  Future<bool> postArriveTime({
    required RoleArrivalType roleArrivalType,
    required int leadId,
    DateTime arrivalTime,
  });
  // c
  void cancelApiRequests();
  Future<void> checkStartInspectionNotUpload({int? inspectionId});
  Future<void> checkTimeArrivalNotUpload();

  // g
  Future<List<InspectionItem>> getAppointments({
    required DateTime date,
    required bool isManager,
    required bool isKv,
  });
  Future<List<InspectionSummary>> getAppointmentSummary({
    required DateTime date,
    required bool isManager,
    required bool isKv,
  });
  Future<List<Buyer>> getBuyers({required int locationId});
  Future<BiddingHistory> getBiddingHistory({
    required int brandId,
    required int modelId,
    required int yearId,
    required int engineId,
    required int variantId,
    required int transmissionId,
  });
  Future<List<Inspector>> getInspectors();
  Future<Metadata> getMetadata();
  Future<List<Remark>> getRemarks({required int leadId});
  Future<List<Slot>> getSlot({
    required int locationId,
    required String date,
    required String time,
  });
  Future<User> getUserProfile();
  // l
  Future<List<Item>> loadLocationList();
  Future<void> logout();
  // p
  Future<bool> postAssignInspector({
    required int inspectorId,
    required int leadId,
  });
  Future<bool> postAssignSlot({
    required String datetime,
    required int leadId,
  });
  Future<void> postRemarks({required int leadId, required String remarks});
  Future<bool> postStatus({
    required int leadId,
    required String status,
    required String remarks,
    String? subStatus,
    String? subStatusOthers,
    DateTime? biddingAfterDate,
    DateTime? followUpDate,
    String? followUpNote,
  });
  // s
  Future<void> saveLocationList({required List<Item> itemList});
  Future<void> saveMetadata({required Metadata metaData});
}

class ServiceImpl implements Service {
// service
  late AnalyticsService analytics;
  late CarLibService carLibService;
  late DeviceInfoService deviceInfoService;
  late FirebaseMessagingService fcmService;
  late InspectionFlowService inspectionFlowService;
  late OngoingInspectionService onGoingInspectionService;
  late NavigationService navigationService;
  late NotificationService notificationService;
  late TemplateService templateService;
  late UserService userService;
  late VersionControlService versionControlService;

// Repository
  late DatabaseRepository database;
  late KeystoreRepository keystore;
  late NetworkRepository network;

  ServiceImpl({
    required this.analytics,
    required this.carLibService,
    required this.deviceInfoService,
    required this.fcmService,
    required this.inspectionFlowService,
    required this.navigationService,
    required this.notificationService,
    required this.templateService,
    required this.userService,
    required this.database,
    required this.keystore,
    required this.network,
    required this.onGoingInspectionService,
    required this.versionControlService,
  });

  final V4AppLibsPreferencesService _appLibsPreferences =
      appLibsLocator<V4AppLibsPreferencesServiceImpl>();

  @override
  Future<void> appInit({
    Role? role,
    String? token,
    String? username,
    int? userId,
  }) async {
    analytics.init();
    final DeployCountry? deployCountry =
        await _appLibsPreferences.getCountrySelected();
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
  Future<void> checkStartInspectionNotUpload({int? inspectionId}) async {
    // TODO: getStartInspectionTimeNotUploaded from DB
    // call postStartInspectionDateTime from nnetwork
    // call setStartInspectionTimeUploaded form DB
  }

  @override
  Future<void> checkTimeArrivalNotUpload() async {
    // TODO: get customerArrival time not uploaded yet from DB
  }

  @override
  Future<List<InspectionItem>> getAppointments({
    required DateTime date,
    required bool isManager,
    required bool isKv,
  }) async {
    final List<InspectionItemDto> result = await network.getAppointments(
        date: date, isManager: isManager, isKv: isKv);
    return result.map((e) => InspectionItem.fromDto(e)).toList();
  }

  @override
  Future<List<InspectionSummary>> getAppointmentSummary({
    required DateTime date,
    required bool isManager,
    required bool isKv,
  }) async {
    final List<InspectionSummaryDto> result = await network
        .getAppointmentSummary(date: date, isManager: isManager, isKv: isKv);
    return result.map((e) => InspectionSummary.fromDto(e)).toList();
  }

  @override
  Future<List<Buyer>> getBuyers({required int locationId}) async {
    final List<BuyerDto> result =
        await network.getBuyers(locationId: locationId);
    return result.map((e) => Buyer.fromDto(e)).toList();
  }

  @override
  Future<BiddingHistory> getBiddingHistory({
    required int brandId,
    required int modelId,
    required int yearId,
    required int engineId,
    required int variantId,
    required int transmissionId,
  }) async {
    final BiddingHistoryDto? result = await network.getBiddingHistory(
      brandId: brandId,
      modelId: modelId,
      yearId: yearId,
      variantId: variantId,
      engineId: engineId,
      transmissionId: transmissionId,
    );
    return BiddingHistory.fromDto(result);
  }

  @override
  Future<List<Inspector>> getInspectors() async {
    final List<InspectorDto> result = await network.getInspectors();
    return result.map((e) => Inspector.fromDto(e)).toList();
  }

  @override
  Future<Metadata> getMetadata() async {
    return await keystore.loadMetadata();
  }

  @override
  Future<List<Remark>> getRemarks({required int leadId}) async {
    final List<RemarkDto> result = await network.getRemarks(leadId: leadId);
    return result.map((e) => Remark.fromDto(e)).toList();
  }

  @override
  Future<List<Slot>> getSlot({
    required int locationId,
    required String date,
    required String time,
  }) async {
    final List<SlotDto> result =
        await network.getSlot(date: date, time: time, locationId: locationId);
    return result.map((e) => Slot.fromDto(e)).toList();
  }

  @override
  Future<List<Item>> loadLocationList() async {
    return await keystore.loadLocationList() ?? [];
  }

  @override
  Future<User> getUserProfile() async {
    final UserDto? result = await network.getUserProfile();
    return User.fromDto(result);
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
        Duration(milliseconds: 100),
        () async =>
            await navigationService.pushAndRemoveUntil(ConstantNav.loginRoute));
  }

  @override
  Future<bool> postArriveTime({
    required RoleArrivalType roleArrivalType,
    required int leadId,
    DateTime? arrivalTime,
  }) async {
    return await network.postArriveTime(
            roleArrivalType: roleArrivalType,
            leadId: leadId,
            dateTime: arrivalTime ?? DateTime.now()) ??
        false;
  }

  @override
  Future<bool> postAssignInspector({
    required int inspectorId,
    required int leadId,
  }) async {
    return await network.postAssignInspector(
            inspectorId: inspectorId, leadId: leadId) ??
        false;
  }

  @override
  Future<bool> postAssignSlot({
    required String datetime,
    required int leadId,
  }) async {
    return await network.postAssignSlot(datetime: datetime, leadId: leadId) ??
        false;
  }

  @override
  Future<void> postRemarks(
      {required int leadId, required String remarks}) async {
    return await network.postRemarks(leadId: leadId, remarks: remarks);
  }

  @override
  Future<void> saveLocationList({required List<Item> itemList}) async {
    await keystore.saveLocationList(itemList);
  }

  @override
  Future<void> saveMetadata({required Metadata metaData}) async {
    await keystore.saveMetadata(metadata: metaData);
  }

  @override
  Future<bool> postStatus({
    required int leadId,
    required String status,
    required String remarks,
    String? subStatus,
    String? subStatusOthers,
    DateTime? biddingAfterDate,
    DateTime? followUpDate,
    String? followUpNote,
  }) async {
    return await network.postStatus(
            leadId: leadId,
            status: status,
            remarks: remarks,
            subStatus: subStatus,
            subStatusOthers: subStatusOthers,
            biddingAfterDate: biddingAfterDate,
            followUpDate: followUpDate,
            followUpNote: followUpNote) ??
        false;
  }
}
