import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'database.enum.dart';

/// Use it internally
/// All databases that used as provider must implement [IDatabase].
/// modify [IDatabase] based on your need.
abstract class IDatabase {
  final DatabaseType databaseType;
  IDatabase({required this.databaseType});

  Future<void> create({required List<DatabaseName> names});
  void closeDatabase({required DatabaseName databaseName});
  Future<bool> deleteDatabaseFile({
    required DatabaseName databaseName,
    required DatabaseType databaseType,
  }) async {
    final directory = await getDatabasePath(
      databaseName: databaseName,
      databaseType: DatabaseType.objectbox,
    );
    final f = File(directory);
    if (f.existsSync()) {
      f.deleteSync();
      return true;
    }
    return false;
  }

  Future<String> getDatabasePath({
    required DatabaseName databaseName,
    required DatabaseType databaseType,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/db/${databaseType.name}/${databaseName.name}';
  }
}
