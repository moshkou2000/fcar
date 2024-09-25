import 'dart:convert';

import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app.provider.dart';
import 'opponent.model.dart';

final opponentRepository = Provider((ref) => OpponentRepository());

class OpponentRepository {
  // TODO: get level, location
  //    from tocken in the backent.

  final _cancelToken = network.newCancelToken;

  void cancelGetOpponent() {
    _cancelToken.cancel('User decline');
  }

  /// It will pick available player randomly
  ///   if the username is not provided(null | empty).
  ///
  /// It will pick the General or random category
  ///   if the category is not provided(null | empty).
  ///
  /// It will be one to one
  ///   if the group is not provided(null | empty).
  Future<OpponentModel?> getOpponent({
    String? category,
    String? group,
    String? username,
  }) async {
    // final url = NetworkUrl.opponent;
    // final queryParam = <String, dynamic>{
    //   'group': group,
    //   'category': category,
    //   'username': username,
    // };
    // final json = await network.get(url,
    //     queryParam: queryParam, cancelToken: _cancelToken);

    // this is mock data
    final dummy = await rootBundle.loadString('asset/mock/opponent.json');
    logger.debug(dummy);
    final dynamic json = jsonDecode(dummy);

    return Deserialize<OpponentModel>(
      json,
      requiredFields: ['username', 'displayname', 'avatar', 'score', 'rank'],
      fromMap: (e, {callback}) => OpponentModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).item; // item | items
  }
}
