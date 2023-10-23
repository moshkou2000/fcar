import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// final indexController = StateProvider<int>((ref) => 0);
/// final idController = StateProvider<String>((ref) => '');
/// final isLoading = StateProvider<bool>((ref) => false);

/// For reusable Notifier Provider
///
/// @override
/// T build() {
///   // return the respective value
///   // example: return 0 when T is int;
/// }
///
/// T toggle(T state) ->
///   T: bool -> toggle the state bool
///   T: String -> reverse the String state
///   T: int -> toggle the state +/-
///   T: double -> toggle the state +/-
///   default -> the state
abstract class BaseController<T> extends AutoDisposeNotifier<T> {
  @override
  bool updateShouldNotify(T previous, T next) => previous != next;

  void setState(T state) => this.state = state;

  /// T: bool -> toggle the state bool
  /// T: String -> reverse the String state
  /// T: int -> toggle the state +/-
  /// T: double -> toggle the state +/-
  /// default -> the state
  void toggleState() {
    if (state is bool) {
      state = !(state as bool) as T;
    } else if (state is String) {
      state = String.fromCharCodes((state as String).runes.toList()) as T;
    } else if (state is int) {
      state = -(state as int) as T;
    } else if (state is double) {
      state = -(state as double) as T;
    }
  }
}

/// For reusable Notifier Provider
///
/// @override
/// T build(V arg) {
///   // return the respective value
///   // example: return 0 when T is int;
/// }
///
abstract class BaseFamilyController<T, V>
    extends AutoDisposeFamilyNotifier<T, V> {
  @override
  bool updateShouldNotify(T previous, T next) => previous != next;

  void setState(T state) => this.state = state;
}

/// For reusable Notifier Provider
///
/// @override
/// bool build() {
///   return false;
/// }
///
/// implement [loadData]
abstract class BaseListController<T> extends BaseController<bool> {
  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final List<T> list = [];

  Future<List<T>> loadData();

  Future<void> clear() async {
    list.clear();
    toggleState();
    refreshController.loadNoData();
  }

  Future<void> init() async {
    try {
      await refreshController.requestLoading();
      final data = await loadData();
      // onCompleted(data);
      list.clear();
      list.addAll(data);
      refreshController.loadComplete();
    } catch (_) {
      refreshController.loadFailed();
    }
  }

  Future<void> refresh() async {
    try {
      await refreshController.requestRefresh();
      final data = await loadData();
      // onCompleted(data);
      list.clear();
      list.addAll(data);
      refreshController.refreshCompleted(resetFooterState: data.isEmpty);
    } catch (_) {
      refreshController.refreshFailed();
    }
  }
}

/// For reusable Notifier Provider
///
/// @override
/// bool build() {
///   return false;
/// }
///
/// implement [loadData] and call [setHasNext]
abstract class BaseListLoadMoreController<T> extends BaseListController<T> {
  int _currentPageNum = 0;
  bool _hasNext = true;

  void setHasNext(bool b) {
    _hasNext = b;
  }

  @override
  Future<List<T>> loadData({int pageNum});

  Future<void> loadMore() async {
    if (_hasNext) {
      try {
        await refreshController.requestLoading();
        final data = await loadData(pageNum: ++_currentPageNum);
        // onCompleted(data);
        list.clear();
        list.addAll(data);
        if (data.isNotEmpty) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      } catch (_) {
        refreshController.loadFailed();
      }
    } else {
      refreshController.loadNoData();
    }
  }
}
