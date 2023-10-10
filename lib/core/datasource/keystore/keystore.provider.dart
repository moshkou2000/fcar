import 'keystore.dart';
import 'keystore.enum.dart';
import 'secure_storage/secure_storage.dart';

abstract class KeystoreProvider {
  late final IKeystore keystore;

  KeystoreProvider() {
    _createSecureStorage();
  }

  void _createSecureStorage() {
    keystore = SecureStorage(KeystoreName.appKeystore.name);
  }
}
