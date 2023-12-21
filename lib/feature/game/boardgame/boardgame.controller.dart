import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../auth/player.model.dart';
import '../../shared/dialog/dialog.dart';
import 'boardgame.repository.dart';

final boardgameController =
    AutoDisposeNotifierProvider<BoardgameController, PlayerModel?>(() {
  return BoardgameController();
});

class BoardgameController extends BaseController<PlayerModel?> {
  late final BoardgameRepository _boardgameRepository;

  @override
  PlayerModel? build() {
    ref.onDispose(() {});
    _boardgameRepository = ref.read(boardgameRepository);
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
    _boardgameRepository.cancelGetOpponent();
  }

  Future<void> _getOpponent({
    String? category,
    String? group,
    String? username,
  }) async {
    final result = await _boardgameRepository.getOpponent(
      category: category,
      group: group,
      username: username,
    );
    if (result != null) {
      state = result;
    }
  }
}
