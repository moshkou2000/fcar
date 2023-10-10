import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

/// [Storage] is used in order to manage files & directories
class Storage with StorageMixin {
  /// compress a file [path] to [targetPath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// return [File]
  Future<StorageItem> compress({
    required StorageItem data,
    required String targetPath,
  }) async {
    return data.fileType == FileType.photo
        ? await compressPhoto(data: data, targetPath: targetPath)
        : await compressVideo(data: data, targetPath: targetPath);
  }

  /// copy [path] to [targetPath].
  Future<bool?> copy(String path, String targetPath) async {
    final File? file = await getFile();
    return await file?.copy(targetPath) != null;
  }

  /// get file by [targetPath] or [path].
  /// return [false] when no file
  Future<bool> delete({String? fileName, String? path}) async {
    final File? file = await getFile(path: path, fileName: fileName);
    final bool flag = file != null;
    file?.deleteSync(recursive: true);
    return flag;
  }

  /// generate file path using [extension].
  /// use [DateTime.now()] when [fileName] is null.
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// return [FileModel]
  Future<FileModel> generateFilePaths({
    required String extension,
    String? fileName,
    String? prefix,
    bool? isTemporary,
  }) async {
    String name = '';
    if (fileName?.trim().isNotEmpty == true) {
      name = '$fileName.$extension';
    } else if (prefix?.trim().isNotEmpty == true) {
      name = '${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension';
    } else {
      name = '${DateTime.now().millisecondsSinceEpoch}.$extension';
    }
    final String directory = (isTemporary ?? false)
        ? (await getTemporaryDirectory()).path
        : (await getApplicationDocumentsDirectory()).path;
    final String path = join(directory, name);
    return FileModel(
        name: name, path: path, directory: directory, extension: extension);
  }

  /// pick the file by [fileName] or [path].
  /// lookup in catche directory if [isTemporary] otherwise app directory when [fileName] has value.
  /// return null when [fileName] or [path] is null or [path] does not exist.
  Future<File?> getFile({
    String? fileName,
    String? path,
    bool? isTemporary,
  }) async {
    File? file;
    String? filePath = path;
    if (fileName != null) {
      final String directory = (isTemporary ?? false)
          ? (await getTemporaryDirectory()).path
          : (await getApplicationDocumentsDirectory()).path;
      filePath = join(directory, fileName);
    }
    if (filePath != null) {
      if (FileSystemEntity.typeSync(filePath) !=
          FileSystemEntityType.notFound) {
        file = File(filePath);
      }
    }
    return file;
  }

  /// move [path] to [targetPath].
  Future<bool> move(String path, String targetPath) async {
    await copy(path, targetPath);
    return await delete(path: path);
  }

  /// save [xFile] to [targetPath] then delete [xFile].
  /// return true when both [xFile] & [targetPath] exist.
  Future<bool> save(XFile xFile, String targetPath,
      {bool? deleteOriginal = true}) async {
    await xFile.saveTo(targetPath);
    if (deleteOriginal == true && targetPath != xFile.path) {
      await delete(path: xFile.path);
    }
    return FileSystemEntity.typeSync(targetPath) !=
        FileSystemEntityType.notFound;
  }
}
