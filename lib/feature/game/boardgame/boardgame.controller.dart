import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../shared/dialog/dialog.dart';
import 'boardgame.repository.dart';
import 'widgets/answer.model.dart';
import 'widgets/boardgame.model.dart';
import 'widgets/question.model.dart';

final boardgameController =
    AutoDisposeNotifierProvider<BoardgameController, BoardgameModel?>(() {
  return BoardgameController();
});

class BoardgameController extends BaseController<BoardgameModel?> {
  late final BoardgameRepository _boardgameRepository;
  final _boardgameData = BoardgameModel();

  @override
  BoardgameModel build() {
    ref.onDispose(() {});
    _boardgameRepository = ref.read(boardgameRepository);
    return BoardgameModel();
  }

  Future<void> init() async {
    try {
      await _getQuestion();
      state = _boardgameData;
    } catch (e, s) {
      logger.error('init', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> onPressedOption({required String id}) async {
    try {
      await _settSelectedOption(id: id);
      await _getQuestion();
      state = _boardgameData;
    } catch (e, s) {
      logger.error('onPressedOption', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> _getQuestion() async {
    final result = await _boardgameRepository.getQuestion();
    if (result != null) {
      _updateBoardgameData(question: result);
    }
  }

  Future<void> _settSelectedOption({required String id}) async {
    final result = await _boardgameRepository.postSelectedOption(id: id);
    if (result != null) {
      _updateBoardgameData(answer: result);
    }
  }

  void _updateBoardgameData({
    AnswerModel? answer,
    QuestionModel? question,
  }) {
    _boardgameData.answer = answer;
    _boardgameData.question = question;
    if (answer?.playerAnswer == true) _boardgameData.playerScore++;
    if (answer?.opponentAnswer == true) _boardgameData.opponentScore++;
  }
}
