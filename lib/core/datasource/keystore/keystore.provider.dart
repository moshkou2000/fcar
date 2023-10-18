import 'keystore.dart';
import 'keystore.enum.dart';
import 'secure_storage/secure_storage.dart';

final IKeystore keystore = SecureStorage(KeystoreName.appKeystore.name);
