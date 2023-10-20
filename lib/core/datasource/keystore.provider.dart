import 'keystore/keystore.dart';
import 'keystore/keystore.enum.dart';
import 'keystore/secure_storage/secure_storage.dart';

export 'keystore/keystore.enum.dart';

final IKeystore keystore = SecureStorage(KeystoreName.appKeystore.name);
