import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/datasource/keystore/keystore.provider.dart';
import '../auth/auth.model.dart';

final splashscreenRepository = Provider((ref) => SplashscreenRepository());

class SplashscreenRepository {
  Future<AuthModel?> getUser() async {
    final result = await keystore.read(key: KeystoreKey.user);
    return result != null ? AuthModel.fromJson(result) : null;
  }
}
