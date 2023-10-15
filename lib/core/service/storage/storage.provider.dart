import 'file_manager/file_manager.dart';
import 'storage.dart';

class StorageProvider {
  late final IStorage storage;

  StorageProvider() {
    _createFileManager();
  }

  void _createFileManager() {
    storage = FileManager();
  }
}
