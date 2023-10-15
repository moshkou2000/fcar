import 'dart:io';

import 'file.model.dart';

/// [IStorage] is used in order to manage files & directories
abstract class IStorage {
  /// compress a file [path] to [targetPath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// return [File]
  Future<File?> compressPhoto({
    required String filePath,
    required String targetPath,
    bool? deleteOriginal = true,
  });

  /// compress [filePath].
  /// generate in catche directory if [isTemporary] otherwise app directory.
  /// if the file size is less than the limit [ValueConstant.maxFileSize]
  ///   return original [File]
  ///   return new [File]
  Future<File?> compressVideo({
    required String filePath,
    required String targetPath,
    bool? deleteOriginal = true,
  });

  /// save [xFile] to [targetPath] then delete [xFile].
  /// delete [xFile.path] when it's not equal [targetPath] if [deleteOriginal].
  /// return true when both [xFile] & [targetPath] exist.
  Future<bool> save(
    File? file,
    String targetPath, {
    bool? deleteOriginal = true,
  });

  /// move [path] to [targetPath].
  Future<bool> move(String path, String targetPath);

  /// copy [path] to [targetPath].
  Future<bool?> copy(String path, String targetPath);

  /// get file by [targetPath] or [path].
  /// return [false] when no file
  Future<bool> delete({required String filePath});

  /// pick the file by [filePath] -> join(directory, fileName).
  Future<File?> getFile({required String filePath});

  /// generate file path using [extension].
  /// use [DateTime.now()] when [fileName] is null.
  /// generate in catche directory if [isTemporary] otherwise app directory.
  ///   [$fileName.$extension] or
  ///   [${prefix}_${DateTime.now().millisecondsSinceEpoch}.$extension] else
  ///   ${DateTime.now().millisecondsSinceEpoch}.$extension
  /// return [FileModel]
  Future<FileModel> generateFilePaths({
    required String extension,
    String? fileName,
    String? prefix,
    bool? isTemporary,
  });
}
