import 'keystore.enum.dart';

abstract class IKeystoreRepository {
  Future<void> clear();
  Future<T?> read<T>({required KeystoreKey key});
  Future<void> remove({required KeystoreKey key});
  Future<void> save({required KeystoreKey key, required Object value});
}
