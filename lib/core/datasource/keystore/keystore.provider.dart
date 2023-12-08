import 'package:fcar_lib/core/datasource/keystore/keystore.dart';
import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:fcar_lib/core/datasource/keystore/secure_storage/secure_storage.dart';

final IKeystore keystore =
    SecureStorage(keystoreName: KeystoreName.appKeystore.name);
