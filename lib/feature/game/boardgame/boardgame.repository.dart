import 'dart:convert';

import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app.provider.dart';
import '../../../config/network_url.constant.dart';
import 'widgets/answer.model.dart';
import 'widgets/question.model.dart';

final boardgameRepository = Provider((ref) => BoardgameRepository());

class BoardgameRepository {
  /// There is single gameplay for each individual player.
  /// Player is not able to have multiple gameplay at a same time.
  Future<QuestionModel?> getQuestion() async {
    // final url = NetworkUrl.question;
    // final queryParam = <String, dynamic>{};
    // final json = await network.get(url,
    //     queryParam: queryParam, cancelToken: _cancelToken);

    // this is mock data
    final dummy = await rootBundle.loadString('asset/mock/question.json');
    final dynamic json = jsonDecode(dummy);
    return Deserialize<QuestionModel>(
      json,
      requiredFields: ['id', 'title', 'type', 'url', 'options'],
      fromMap: (e, {callback}) => QuestionModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).item; // item | items
  }

  Future<AnswerModel?> postSelectedOption({required String id}) async {
    const url = NetworkUrl.selectedOption;
    final body = <String, dynamic>{'id': id};
    final json = await network.post(url, body: body);
    return Deserialize<AnswerModel>(
      json,
      requiredFields: ['playerAnswer', 'opponentAnswer'],
      fromMap: (e, {callback}) => AnswerModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).item; // item | items
  }
}
