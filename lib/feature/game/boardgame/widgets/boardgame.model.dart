import 'answer.model.dart';
import 'question.model.dart';

class BoardgameModel {
  AnswerModel? answer;
  QuestionModel? question;
  int playerScore;
  int opponentScore;

  BoardgameModel({
    this.answer,
    this.question,
    this.playerScore = 0,
    this.opponentScore = 0,
  });
}
