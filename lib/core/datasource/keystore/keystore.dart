import '../../../shared/domain/repository/keystore/keystore.enum.dart';

/// All Keystore datasources that used as provider must implement [IKeystore]
/// modify [IDatabase] based on your need.
abstract class IKeystore {
  String get keystoreName;
  Future<void> clear();
  Future<T?> read<T>({required KeystoreKey key});
  Future<void> remove({required KeystoreKey key});
  Future<void> save({required KeystoreKey key, required Object value});
}
