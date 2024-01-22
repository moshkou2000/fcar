import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../shared/dialog/dialog.dart';
import 'opponent.model.dart';
import 'opponent.repository.dart';

final opponentController =
    AutoDisposeNotifierProvider<OpponentController, OpponentModel?>(() {
  return OpponentController();
});

class OpponentController extends BaseController<OpponentModel?> {
  late final OpponentRepository _opponentRepository;

  @override
  OpponentModel? build() {
    ref.onDispose(() {});
    _opponentRepository = ref.read(opponentRepository);
    return null;
  }

  Future<void> onPressedSearch({
    String? category,
    String? group,
    String? username,
  }) async {
    try {
      await getOpponent(
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

  Future<void> getOpponent({
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
