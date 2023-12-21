import 'dart:convert';

import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/datasource/network/network.provider.dart';
import '../../auth/player.model.dart';

final boardgameRepository = Provider((ref) => BoardgameRepository());

class BoardgameRepository {
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
  Future<PlayerModel?> getOpponent({
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
    final dynamic json = jsonDecode(dummy);

    return Deserialize<PlayerModel>(
      json,
      requiredFields: ['username', 'displayname', 'rank', 'avatar'],
      fromJson: (e, {callback}) => PlayerModel.fromMap(e),
      callback: (missingKeys) => throw Exception(missingKeys),
    ).item; // item | items
  }
}
