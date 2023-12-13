import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/datasource/keystore/keystore.provider.dart';
import '../../auth/player.model.dart';

final playerRepository = Provider((ref) => PlayerRepository());

class PlayerRepository {
  Future<PlayerModel?> get profile async {
    final _ = await keystore.read(key: KeystoreKey.profile);
    logger.info(_);
    return await keystore.read<PlayerModel>(key: KeystoreKey.profile);
  }
}
