import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../config/constant/value.constant.dart';
import '../../crashlytics/crashlytics.dart';
import '../file.model.dart';
import '../storage.dart';

/// [FileManager] is used in order to manage files & directories
class FileManager implements IStorage {
  static final FileManager _singleton = FileManager._internal();
  factory FileManager() => _singleton;
  FileManager._internal();

  /// compress a file [path] to [targetPath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// return [File]
  @override
  Future<File?> compressPhoto({
    required String filePath,
    required String targetPath,
    bool? deleteOriginal = true,
  }) async {
    final file = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      minWidth: ValueConstant.desirePhotoWidth,
      minHeight: ValueConstant.desirePhotoHeight,
      quality: ValueConstant.desirePhotoQuality,
      autoCorrectionAngle: false,
      format: CompressFormat.jpeg,
    ).catchError((e, s) {
      //TODO: capture exceptions for logging
      if (kDebugMode) {
        print('Storage.compress.error: $e');
      }
      Crashlytics.recordError(e, s, reason: 'compressPhoto($filePath)');
      return null;
    });

    return file != null ? File(file.path) : null;
  }

  /// compress [filePath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// if the file size is less than the limit [ValueConstant.maxFileSize]
  ///   return original [File]
  ///   return new [File]
  @override
  Future<File?> compressVideo({
    required String filePath,
    required String targetPath,
    bool? deleteOriginal = true,
  }) async {
    final fileInfo = await VideoCompress.getMediaInfo(filePath);
    if (fileInfo.file == null) return null;

    // return the original video file
    // if the file size is less than the limit [ValueConstant.maxFileSize]
    if (fileInfo.filesize! < ValueConstant.maxFileSize) {
      return fileInfo.file;
    }

    await VideoCompress.setLogLevel(1);
    var info = await VideoCompress.compressVideo(
      fileInfo.file!.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    // logic
    // return when file size is less than the limit [ValueConstant.maxFileSize]
    if (info?.filesize != null && info!.filesize! < ValueConstant.maxFileSize) {
      return info.file;
    }
    do {
      final quality = info!.height! > 1280
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
    } while (
        info?.filesize != null && info!.filesize! > ValueConstant.maxFileSize);

    await save(info?.file, targetPath, deleteOriginal: deleteOriginal);
    return File(targetPath);
  }

  /// save [xFile] to [targetPath] then delete [xFile].
  /// delete [xFile.path] when it's not equal [targetPath] if [deleteOriginal].
  /// return true when both [xFile] & [targetPath] exist.
  @override
  Future<bool> save(
    File? file,
    String targetPath, {
    bool? deleteOriginal = true,
  }) async {
    if (file != null) {
      file.copy(targetPath);
    }

    if (deleteOriginal == true) {
      var path = file?.path;
      if (path != null && path != targetPath) {
        await delete(filePath: path);
      }
    }
    return FileSystemEntity.typeSync(targetPath) !=
        FileSystemEntityType.notFound;
  }

  /// move [path] to [targetPath].
  @override
  Future<bool> move(String path, String targetPath) async {
    final c = await copy(path, targetPath);
    return c == true ? await delete(filePath: path) : false;
  }

  /// copy [path] to [targetPath].
  @override
  Future<bool?> copy(String path, String targetPath) async {
    final file = await getFile(filePath: path);
    return await file?.copy(targetPath) != null;
  }

  /// get file by [targetPath] or [path].
  /// return [false] when no file
  @override
  Future<bool> delete({required String filePath}) async {
    final file = await getFile(filePath: filePath);
    final flag = file != null;
    await file?.delete(recursive: true);
    return flag;
  }

  /// pick the file by [filePath] -> join(directory, fileName).
  @override
  Future<File?> getFile({required String filePath}) async {
    if (FileSystemEntity.typeSync(filePath) != FileSystemEntityType.notFound) {
      return File(filePath);
    }
    return null;
  }

  /// generate file path using [extension].
  /// use [DateTime.now()] when [fileName] is null.
  /// generate in catche directory if [isTemporary] otherwise app directory.
  ///   [$fileName.$extension] or
  ///   [${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension] else
  ///   ${DateTime.now().millisecondsSinceEpoch}.$extension
  /// return [FileModel]
  @override
  Future<FileModel> generateFilePaths({
    required String extension,
    String? fileName,
    String? prefix,
    bool? isTemporary,
  }) async {
    var name = '';
    if (fileName?.trim().isNotEmpty == true) {
      name = '$fileName.$extension';
    } else if (prefix?.trim().isNotEmpty == true) {
      name = '${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension';
    } else {
      name = '${DateTime.now().millisecondsSinceEpoch}.$extension';
    }
    final directory = (isTemporary ?? false)
        ? (await getTemporaryDirectory()).path
        : (await getApplicationDocumentsDirectory()).path;
    final path = join(directory, name);
    return FileModel(
      directory: directory,
      extension: extension,
      name: name,
      path: path,
    );
  }
}
