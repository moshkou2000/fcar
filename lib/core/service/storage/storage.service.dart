import 'dart:io';

import 'package:camera/camera.dart';

import '../../../config/constant/value.constant.dart';
import '../task_runner.dart';

final StorageService storageService = StorageServiceImpl();

/// [StorageService] is a task runner
/// initialy
///
abstract class StorageService {
  void init({
    required Future<void> Function(StorageItem) callback,
    Function()? onComplete,
  });

  void add({required StorageItem data});

  void addAll({required List<StorageItem> data});

  void clear();

  Future<bool> delete({String? fileName, String? path});

  Future<FileModel> generateFilePaths({
    required String extension,
    String? fileName,
    String? prefix,
    bool? isTemporary,
  });

  Future<File?> getFile({String? fileName, String? path, bool? isTemporary});

  Future<bool> save(XFile xFile, String targetPath,
      {bool? deleteOriginal = true});
}

class StorageServiceImpl implements StorageService {
  final Storage _storage = Storage();
  TaskRunner<StorageItem>? runner;

  Future<StorageItem> _compress(StorageItem item) async => await _storage
      .compress(data: item, targetPath: 'PASS THE PATH AS A STRING HERE');

  @override
  void init({
    required Future<void> Function(StorageItem) callback,
    Function()? onComplete,
  }) {
    runner = runner ??
        TaskRunner(_compress, callback,
            maxConcurrentTasks: ValueConstant.iMaxConcurrentTasks);
  }

  @override
  void add({required StorageItem data}) {
    runner?.add(data);
  }

  @override
  void addAll({required List<StorageItem> data}) {
    runner?.addAll(data);
  }

  @override
  void clear() {
    runner?.clear();
  }

  @override
  Future<bool> delete({String? fileName, String? path}) async {
    return await _storage.delete(fileName: fileName, path: path);
  }

  @override
  Future<FileModel> generateFilePaths({
    required String extension,
    String? fileName,
    String? prefix,
    bool? isTemporary,
  }) async {
    return await _storage.generateFilePaths(
      extension: extension,
      fileName: fileName,
      prefix: prefix,
      isTemporary: isTemporary,
    );
  }

  @override
  Future<File?> getFile({
    String? fileName,
    String? path,
    bool? isTemporary,
  }) async {
    return await _storage.getFile(
      fileName: fileName,
      path: path,
      isTemporary: isTemporary,
    );
  }

  @override
  Future<bool> save(
    XFile xFile,
    String targetPath, {
    bool? deleteOriginal = true,
  }) async {
    return await _storage.save(
      xFile,
      targetPath,
      deleteOriginal: deleteOriginal,
    );
  }
}
