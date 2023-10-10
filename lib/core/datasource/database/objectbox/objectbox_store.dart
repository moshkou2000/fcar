import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';

import '../../../crashlytics.dart';
import '../database.dart';
import '../database.enum.dart';

ObjectboxStore objectboxStore = ObjectboxStore();

class ObjectboxStore extends IDatabase {
  final Map<DatabaseName, Store> _objectboxStores = {};

  ObjectboxStore() : super(databaseType: DatabaseType.objectbox);

  /// The best time to initialize ObjectBox is when your app starts.
  @override
  Future<void> create({required List<DatabaseName> names}) async {
    for (final e in names) {
      if (!_objectboxStores.containsKey(e)) {
        final store = await _createStore(databaseName: e);
        if (store != null) {
          _objectboxStores.addAll({e: store});
          if (kDebugMode) {
            print('ObjectboxStore.create: new [$e] store');
          }
        }
        if (kDebugMode) {
          if (store == null) {
            print('ObjectboxStore.create: store is null for [$e]');
          }
        }
      } else {
        if (kDebugMode) {
          print('ObjectboxStore.create: [$e] exists');
        }
      }
    }
  }

  Store? getStore({required DatabaseName databaseName}) {
    if (_objectboxStores.containsKey(databaseName)) {
      final s = _objectboxStores[databaseName];
      if (kDebugMode) {
        if (s == null) {
          print('ObjectboxStore.create: store is null for [$databaseName]');
        }
      }
      return s;
    } else {
      if (kDebugMode) {
        print('ObjectboxStore.store: [$databaseName] does not exist');
      }
    }
    return null;
  }

  /// Create an instance of ObjectBox to use throughout the app.
  Future<Store?> _createStore({required DatabaseName databaseName}) async {
    try {
      final directory = await getDatabasePath(
        databaseName: databaseName,
        databaseType: DatabaseType.objectbox,
      );
      return null;
      // await openStore(directory: directory);
    } catch (e, s) {
      debugPrint(
          'ObjectboxStore._createStore: database(${databaseName.name}): $e');
      Crashlytics.recordError(
        e,
        s,
        reason: 'ObjectboxStore._createStore database(${databaseName.name})',
      );
    }
    return null;
  }

  // late final DatabaseBox<T> box;
  //
  // DatabaseService({required DatabaseName name}) {
  //   databaseProvider(name);
  //   if (database?.store != null) {
  //     box = DatabaseBox<T>(database!.store!);
  //   }
  //
  //   keystoreServise.read(key: KeystoreKey.eTag).then((value) {
  //     if (value != null) {
  //       box.eTags = value;
  //     }
  //   });
  // }
}
