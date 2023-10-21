import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../keystore.dart';
import '../keystore.enum.dart';

/// The base methods
/// to _read & write bool, int, double & string
/// and also remove data or clear the storage
/// All the derived classes use the same storage [_storage]
class SecureStorage implements IKeystore {
  late final String key;

  SecureStorage(this.key);

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  String get keystoreName => key;

  @override
  Future<void> clear() async => await _deleteAll();

  @override
  Future<T?> read<T>({required KeystoreKey key}) async {
    if (T is bool) {
      return await _readBool(key.name) as T;
    } else if (T is String) {
      return await _readString(key.name) as T;
    } else if (T is int) {
      return await _readInt(key.name) as T;
    } else if (T is double) {
      return await _readDouble(key.name) as T;
    }
    return null;
  }

  @override
  Future<void> remove({required KeystoreKey key}) async =>
      await _delete(key.name);

  @override
  Future<void> save({required KeystoreKey key, required Object value}) async =>
      await _write(key.name, json.encode(value));

  Future<bool?> _readBool(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : bool.tryParse(value);
  }

  Future<int?> _readInt(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : int.tryParse(value);
  }

  Future<double?> _readDouble(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : double.tryParse(value);
  }

  Future<String?> _readString(String key,
          {bool useOriginalKey = false}) async =>
      await _storage.read(key: _fixKey(key, useOriginalKey));

  Future<void> _write(
    String key,
    dynamic value, {
    bool useOriginalKey = false,
  }) async =>
      await _storage.write(
          key: _fixKey(key, useOriginalKey),
          value: value != null ? value.toString() : '');

  Future<void> _delete(String key, {bool useOriginalKey = false}) async =>
      await _storage.delete(key: _fixKey(key, useOriginalKey));

  Future<void> _deleteAll() async => await _storage.deleteAll();

  String _fixKey(key, bool useOriginalKey) =>
      useOriginalKey ? key : '${this.key}_$key';
}
