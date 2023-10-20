import 'package:flutter/material.dart';

import 'database/collection.dart';
import 'database/database.enum.dart';
import 'database/objectbox/objectbox.dart';
import 'database/objectbox/objectbox_store.dart';

export 'database/collection.dart';
export 'database/database.enum.dart';

@immutable
abstract final class DatabaseProvider {
  static void setup({
    required Map<DatabaseType, List<DatabaseName>> names,
  }) {
    names.forEach((key, value) async {
      switch (key) {
        case DatabaseType.objectbox:
          await objectboxStore.create(names: value);
          break;
        // case DatabaseType.sqlite:
        // // TODO: Handle this case.
        // case DatabaseType.hive:
        // // TODO: Handle this case.
      }
    });
  }

  static void closeDatabase({
    required DatabaseType databaseType,
    required DatabaseName databaseName,
  }) {
    switch (databaseType) {
      case DatabaseType.objectbox:
        objectboxStore.closeDatabase(databaseName: databaseName);

      // case DatabaseType.sqlite:
      // // TODO: Handle this case.
      // case DatabaseType.hive:
      // // TODO: Handle this case.
    }
  }

  static Future<bool> dropDatabase({
    required DatabaseType databaseType,
    required DatabaseName databaseName,
  }) async {
    switch (databaseType) {
      case DatabaseType.objectbox:
        return await objectboxStore.deleteDatabaseFile(
            databaseName: databaseName, databaseType: databaseType);

      // case DatabaseType.sqlite:
      // // TODO: Handle this case.
      // case DatabaseType.hive:
      // // TODO: Handle this case.
    }
  }

  static ICollection<T>? getCollection<T>({
    required DatabaseType databaseType,
    required DatabaseName databaseName,
  }) {
    switch (databaseType) {
      case DatabaseType.objectbox:
        final store = objectboxStore.getStore(databaseName: databaseName);
        if (store != null) {
          return Objectbox<T>(store: store);
        }
      // case DatabaseType.sqlite:
      // // TODO: Handle this case.
      // case DatabaseType.hive:
      // // TODO: Handle this case.
    }
    return null;
  }
}
