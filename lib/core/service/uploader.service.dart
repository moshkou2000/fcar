import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspector/constant/crashlytics.constant.dart';
import 'package:inspector/constant/enum/file_type.dart';
import 'package:inspector/core/application/inspection_flow/inspection_flow_type.enum.dart';
import 'package:inspector/core/application/navigation.service.dart';
import 'package:inspector/core/application/ongoing_inspection/ongoing_inspection.service.dart';
import 'package:inspector/core/application/storage/storage.service.dart';
import 'package:inspector/core/data/dto/inspection_photo.dto.dart';
import 'package:inspector/core/data/dto/ongoing_inspection/ongoing_inspection.dto.dart';
import 'package:inspector/core/data/repository/database/database.repository.dart';
import 'package:inspector/core/data/repository/network/network.repository.dart';
import 'package:inspector/core/data/repository/network/network_exception.dart';
import 'package:inspector/core/domain/localization/get_localization.dart';
import 'package:inspector/core/domain/model/inspection_photo.dart';
import 'package:inspector/core/domain/model/ongoing_inspection/ongoing_inspection.dart';
import 'package:inspector/core/domain/model/storage_item.dart';
import 'package:inspector/core/domain/model/uploader_queue.dart';
import 'package:inspector/ui/home/inspector/inspector.controller.dart';
import 'package:inspector/ui/shared/providers.dart';
import 'package:v4_app_libs/v4_app_libs.dart';

final uploaderService = Provider<UploaderService>((ref) {
  return UploaderService(ref);
});

class UploaderService {
  late final DatabaseRepository _database;
  late final InspectorController _inspectorController;
  late final NavigationService _navigationService;
  late final NetworkRepository _networkRepository;
  late final OngoingInspectionService _ongoingService;
  late final StorageService _storageService;
  late final StreamController<UploaderQueue> _streamController;

  UploaderService(ProviderRef ref) {
    ref.onDispose(() => _streamController.close());
    _database = ref.read(databaseRepository);
    _inspectorController = ref.read(inspectorController.notifier);
    _navigationService = ref.read(navigationService);
    _networkRepository = ref.read(networkRepository);
    _ongoingService = ref.read(ongoingInspectionService);
    _storageService = ref.read(storageService);
    _storageService.init(callback: uploader);
    _streamController = StreamController<UploaderQueue>.broadcast();
  }

  Stream<UploaderQueue> get stream => _streamController.stream;

  // used to store
  final List<UploaderQueue> _queue = [];

  bool addToQueue(
    int leadId,
    List<StorageItem> medias, {
    bool isUpdateQ = true,
  }) {
    if (medias.isNotEmpty) {
      _inspectorController.changeToInProgress(leadId);
      if (isUpdateQ) {
        _resetQueue(leadId);
        _queue.add(UploaderQueue(leadId: leadId, total: medias.length));
        _updateQueue(leadId: leadId, isSuccess: true, isMediaUploader: true);
      }
      _storageService.addAll(data: medias);
    }
    return medias.isNotEmpty;
  }

  void stopUpload() {
    _storageService.clear();
  }

  // Method used to resume upload when app is killed/terminated
  void resumeUpload() {
    // TODO: incompleted method
    // find ongoinginspection == uploading
    // use the leadId above to find all medias == uploading && failed
    // => upload medias & report
    final List<InspectionPhoto> data = _ongoingService.getOngoingInspectionPhoto
        .where((e) =>
            e.photoStatus == UploadStatus.uploading &&
            e.photoPath?.isNotEmpty == true)
        .toList();

    final InspectionPhoto? inspectionMedia =
        data.firstWhereOrNull((e) => e.leadId != -1);
    if (inspectionMedia != null) {
      final int leadId = inspectionMedia.leadId;
      if (data.isNotEmpty) {
        final List<StorageItem> medias = data
            .map((e) => StorageItem(
                  leadId: leadId,
                  path: e.photoPath!,
                  fileType: e.fileType,
                  fileName: e.photoUniqueNameKey.isNotEmpty
                      ? e.photoUniqueNameKey
                      : (e.categoryNameKey.isNotEmpty
                          ? e.categoryNameKey
                          : e.nameKey),
                  nameKey: e.nameKey,
                  categoryNameKey: e.categoryNameKey,
                  totalFiles: data.length,
                ))
            .toList();
        addToQueue(leadId, medias);
      }
    }
  }

  Future<void> reUpload(int leadId, {bool isUpdateQ = true}) async {
    _storageService.clear();

    // get all failed & uploading medias
    final List<InspectionPhoto> photos = [];
    photos.addAll(_ongoingService.getMediaFailed
        .where((e) => e.photoPath?.isNotEmpty == true && e.leadId == leadId)
        .toList());
    photos.addAll(_ongoingService.getMediaUploading
        .where((e) => e.photoPath?.isNotEmpty == true && e.leadId == leadId)
        .toList());
    final List<StorageItem> medias = photos
        .map((e) => StorageItem(
              leadId: leadId,
              path: e.photoPath!,
              fileType: e.fileType,
              fileName: e.photoUniqueNameKey.isNotEmpty
                  ? e.photoUniqueNameKey
                  : (e.categoryNameKey.isNotEmpty
                      ? e.categoryNameKey
                      : e.nameKey),
              nameKey: e.nameKey,
              categoryNameKey: e.categoryNameKey,
              totalFiles: photos.length,
            ))
        .toList();

    if (medias.isNotEmpty) {
      addToQueue(leadId, medias, isUpdateQ: isUpdateQ);
    } else {
      if (isUpdateQ) {
        _resetQueue(leadId);
        _queue.add(UploaderQueue(leadId: leadId, total: medias.length));
        _updateQueue(leadId: leadId, isSuccess: true, isMediaUploader: true);
      }
      // TODO: required [reportId] from db for possible [edit report]
      await submitReport(leadId: leadId);
    }
  }

  Future<void> uploader(StorageItem data, {bool isUpdateQ = true}) async {
    final UploaderQueue? q =
        _queue.firstWhereOrNull((e) => e.leadId == data.leadId);
    debugPrint('uploader: ${data.toString()}');
    final int leadId = data.leadId;
    if (q == null) return;

    try {
      final MultipartFile multipartFile = await _getMultipartFile(data);
      final InspectionPhotoDto? result = await _networkRepository.uploadMedia(
        medias: [multipartFile],
        leadId: data.leadId,
        isVideo: data.fileType == FileType.video,
      );

      if (result != null) {
        final InspectionPhoto? photoToUpdate =
            _ongoingService.getMediaUploadingAndFailed.firstWhereOrNull((e) {
          if (e.leadId != data.leadId) return false;
          if (data.categoryNameKey.isNotEmpty) {
            return e.categoryNameKey == data.categoryNameKey;
          }
          return e.nameKey == data.nameKey;
        });

        if (photoToUpdate != null) {
          photoToUpdate.leadId = data.leadId;
          photoToUpdate.mediaId = result.mediaId;
          photoToUpdate.photoStatus = UploadStatus.completed;
          photoToUpdate.url = result.url;
          photoToUpdate.originalUrl = result.originalUrl;
          photoToUpdate.thumbnailUrl = result.thumbnailUrl;
          _ongoingService.updateInspectionPhoto(photoToUpdate);
          if (isUpdateQ) {
            _updateQueue(
              leadId: data.leadId,
              isSuccess: true,
              isMediaUploader: true,
            );
          }
        }
      }

      // create report after last media upload
      if (q.isCompleted == true) {
        final bool isAnyFailed = _ongoingService.getMediaFailed.any((e) =>
            e.leadId == data.leadId && e.photoStatus == UploadStatus.failed);
        if (isAnyFailed) {
          await reUpload(leadId, isUpdateQ: false);
        } else {
          // TODO: required [reportId] from db for possible [edit report]
          await submitReport(leadId: data.leadId);
        }
      }
    } on NetworkException catch (e, s) {
      final String errorMsg = e.message.isNotEmpty
          ? e.message
          : getLocalization.noInternetConnectionMsg;
      _handleFailure(
        exception: e,
        stack: s,
        type: 'upload media',
        message: errorMsg,
        reason: errorMsg,
        leadId: leadId,
        isMediaUploader: true,
        showDialog: q.failed <= 1,
        storageItem: data,
      );
    } catch (e, s) {
      _handleFailure(
        exception: e,
        stack: s,
        type: 'upload media',
        message: e.toString(),
        reason: data.toString(),
        leadId: leadId,
        isMediaUploader: true,
        showDialog: q.failed <= 1,
      );
    }
  }

  Future<void> submitReport({required int leadId, String? reportId}) async {
    InspectionFlowType? type;
    try {
      final result = await _ongoingService.getPayload(leadId: leadId);
      type = result.$1;
      final Map<String, dynamic> body = result.$3;

      int? inspectionId;
      if (type == InspectionFlowType.create) {
        inspectionId = await _networkRepository.createReport(body: body);
      } else {
        if (reportId == null) {
          throw '[reportId] must not be null!!!';
        }

        final bool? isUpdated = await _networkRepository.updateReport(
          body: body,
          reportId: reportId,
        );

        if (isUpdated == true) {
          inspectionId = result.$2;
        }
      }

      if (inspectionId != null) {
        _updateInspectionStatus(leadId, UploadStatus.completed);
        // delete everything related to this leadId after upload success
        _queue.removeWhere((e) => e.leadId == leadId);
        _ongoingService.removeAllByLeadId(leadId);
        unawaited(_inspectorController.refresh());
      }
      _updateQueue(leadId: leadId, isSuccess: true, isMediaUploader: false);
      _showUploadReportDialog(inspectionId, leadId: leadId);
    } on NetworkException catch (e, s) {
      _handleFailure(
        exception: e,
        stack: s,
        type: type?.name ?? 'submit',
        message: e.message,
        reason: e.message,
        leadId: leadId,
        isMediaUploader: false,
        showDialog: false,
      );
    } catch (e, s) {
      _handleFailure(
        exception: e,
        stack: s,
        type: type?.name ?? 'submit',
        message: e.toString(),
        reason: e.toString(),
        leadId: leadId,
        isMediaUploader: false,
        showDialog: false,
      );
    }
  }

  Future<MultipartFile> _getMultipartFile(StorageItem item) async {
    return MultipartFile.fromFile(
      item.file != null ? item.file!.path : item.path,
      filename: item.extendedFileName,
      contentType: item.mediaType,
    );
  }

  void _handleFailure({
    required dynamic exception,
    required StackTrace? stack,
    required String type,
    required String message,
    required String reason,
    required int leadId,
    required bool isMediaUploader,
    required bool showDialog,
    StorageItem? storageItem,
  }) {
    stopUpload();
    debugPrint('Failed to $type report for leadId $leadId');
    debugPrint('Message: $message');
    debugPrint('Reason: $reason');
    Crashlytics.recordError(
      exception,
      stack,
      reason: 'uploaderService<$type>: $reason',
    );
    if (isMediaUploader) {
      if (storageItem != null) {
        _updatePhotoStatus(storageItem, UploadStatus.failed);
      }
    } else {
      _updateInspectionStatus(leadId, UploadStatus.failed);
    }
    _updateQueue(
      leadId: leadId,
      isSuccess: false,
      isMediaUploader: isMediaUploader,
    );
    if (showDialog) {
      _showUploadReportDialog(null, leadId: leadId, errorMsg: message);
    }
  }

  void _resetQueue(int leadId) {
    final UploaderQueue? q = _queue.firstWhereOrNull((e) => e.leadId == leadId);

    if (q != null) {
      _queue.remove(q);
    }
  }

  void _showUploadReportDialog(
    int? inspectionId, {
    int? leadId,
    String? errorMsg,
  }) {
    final BuildContext? context = _navigationService.context;

    if (context != null) {
      if (inspectionId == null) {
        // error
        final String subtitle =
            errorMsg == getLocalization.noInternetConnectionMsg
                ? '$errorMsg'
                : '${getLocalization.sorryEncounteredProblem}\n$errorMsg';
        showBottomDialogComponent(
          barrierDismissible: false,
          context: context,
          title: getLocalization.uploadFailed,
          subtitle: subtitle,
          primaryActionText: getLocalization.retryNow,
          onPrimaryActionPressed: (_) {
            if (leadId != null) reUpload(leadId);
            _navigationService.pop();
          },
          secondaryActionText: getLocalization.retryLater,
          onSecondaryActionPressed: (_) => _navigationService.pop(),
        );
      } else {
        // success
        showBottomDialogComponent(
          barrierDismissible: false,
          context: context,
          title: getLocalization.uploadSuccesful,
          subtitleChildren: [
            TextSpan(
                text: '${getLocalization.inspectionReportUploadSuccess1}',
                style: RobotoStyle.paragraph400Small
                    .copyWith(color: ThemeColor.gray500)),
            TextSpan(
                text: '[ID $inspectionId]',
                style: RobotoStyle.paragraph400Small
                    .copyWith(color: ThemeColor.lightBlue)),
            TextSpan(
                text: '${getLocalization.inspectionReportUploadSuccess2}',
                style: RobotoStyle.paragraph400Small
                    .copyWith(color: ThemeColor.gray500))
          ],
          primaryActionText: getLocalization.okay,
          onPrimaryActionPressed: (_) => _navigationService.pop(),
        );
      }
    }
  }

  void _updateInspectionStatus(int leadId, UploadStatus status) {
    final OnGoingInspectionDto? inspectionDto =
        _database.loadOngoingInspectionByLeadId(leadId);

    if (inspectionDto != null) {
      _database.updateOngoingStatus(
          OnGoingInspection.fromDto(inspectionDto), status);
    }
  }

  void _updatePhotoStatus(StorageItem data, UploadStatus status) {
    final InspectionPhoto? photoToUpdate =
        _ongoingService.getMediaUploadingAndFailed.firstWhereOrNull((e) {
      if (e.leadId != data.leadId) return false;
      if (data.categoryNameKey.isNotEmpty) {
        return e.categoryNameKey == data.categoryNameKey;
      }
      return e.nameKey == data.nameKey;
    });

    if (photoToUpdate != null) {
      photoToUpdate.photoStatus = status;
      _ongoingService.updateInspectionPhoto(photoToUpdate);
    }
  }

  void _updateQueue({
    required int leadId,
    required bool isSuccess,
    required bool isMediaUploader,
  }) {
    final UploaderQueue? q = _queue.firstWhereOrNull((e) => e.leadId == leadId);

    if (q != null) {
      if (isSuccess) {
        if (isMediaUploader) {
          q.uploaded += 1;
        } else {
          q.isReportCreated = true;
        }
      } else {
        if (isMediaUploader) {
          q.failed += 1;
        } else {
          q.isReportCreated = false;
          q.failed += 1;
        }
      }
      _streamController.add(q);
    }
    debugPrint('_updateQueue: ${q.toString()}');
  }
}
