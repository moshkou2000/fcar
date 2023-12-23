import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../auth/player.model.dart';
import '../../shared/dialog/dialog.dart';
import 'opponent.repository.dart';

final opponentController =
    AutoDisposeNotifierProvider<PlayerController, PlayerModel?>(() {
  return PlayerController();
});

class PlayerController extends BaseController<PlayerModel?> {
  late final OpponentRepository _opponentRepository;

  @override
  PlayerModel? build() {
    ref.onDispose(() {});
    _opponentRepository = ref.read(opponentRepository);
    return null;
  }

  Future<void> onPressedSearch({
    String? username,
    String? category,
    String? group,
  }) async {
    try {
      await _getOpponent(
        category: category,
        group: group,
        username: username,
      );
    } catch (e, s) {
      logger.error('onPressedSearch', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  void onPressedDecline() {
    _opponentRepository.cancelGetOpponent();
  }

  Future<void> _getOpponent({
    String? category,
    String? group,
    String? username,
  }) async {
    final result = await _opponentRepository.getOpponent(
      category: category,
      group: group,
      username: username,
    );
    if (result != null) {
      state = result;
    }
  }
}
