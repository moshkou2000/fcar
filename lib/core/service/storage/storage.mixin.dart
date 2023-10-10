import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:inspector/constant/value.constant.dart';
import 'package:inspector/core/domain/model/storage_item.dart';
import 'package:video_compress/video_compress.dart';

const int _maxFileSize = 10485760;

mixin StorageMixin {
  /// compress a file [path] to [targetPath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// return [File]
  Future<StorageItem> compressPhoto({
    required StorageItem data,
    required String targetPath,
  }) async {
    data.file = await FlutterImageCompress.compressAndGetFile(
      data.path,
      targetPath,
      minWidth: ConstantValue.desirePhotoWidth,
      minHeight: ConstantValue.desirePhotoHeight,
      quality: ConstantValue.desirePhotoQuality,
      autoCorrectionAngle: false,
      format: CompressFormat.jpeg,
    ).catchError((e, s) {
      //TODO: capture exceptions for logging
      debugPrint('Storage.compress.error: $e');
      unawaited(FirebaseCrashlytics.instance
          .recordError(e, s, reason: 'Storage.compress: ${data.toString()}'));
      return null;
    });

    return data;
  }

  Future<StorageItem> compressVideo({
    required StorageItem data,
    required String targetPath,
  }) async {
    await VideoCompress.setLogLevel(1);
    final MediaInfo infoOriginal = await VideoCompress.getMediaInfo(data.path);
    // return the original video file
    // if the file size is less than the limit [_maxFileSize]
    if (infoOriginal.filesize! < _maxFileSize) {
      data.file = infoOriginal.file;
      return data;
    }
    MediaInfo? info = await VideoCompress.compressVideo(
      data.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    // return when file size is less than the limit [_maxFileSize]
    if (info?.filesize != null && info!.filesize! < _maxFileSize) {
      data.file = info.file;
      return data;
    }
    do {
      final VideoQuality quality = info!.height! > 1280
          ? VideoQuality.Res1280x720Quality
          : info.height! > 960
              ? VideoQuality.Res960x540Quality
              : VideoQuality.Res640x480Quality;
      info = await VideoCompress.compressVideo(
        info.path!,
        quality: quality,
        deleteOrigin: false,
        includeAudio: true,
      );
    } while (info?.filesize != null && info!.filesize! > _maxFileSize);

    data.file = info?.file;
    return data;
  }
}
