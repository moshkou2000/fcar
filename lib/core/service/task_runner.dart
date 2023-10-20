import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

class TaskRunner<T> {
  final int maxConcurrentTasks;
  final Future<T> Function(T) task;
  final Future<void> Function(T) callback;

  int _runningTasks = 0;
  final Queue<T> _queue = Queue();

  bool get _isRunTask =>
      _queue.isNotEmpty && _runningTasks < maxConcurrentTasks;

  TaskRunner(
    this.task,
    this.callback, {
    this.maxConcurrentTasks = 5,
  });

  /// add into the queque
  void add(T value) {
    _queue.add(value);
    _startExecution();
  }

  void addAll(Iterable<T> iterable) {
    _queue.addAll(iterable);
    _startExecution();
  }

  void clear() {
    _queue.clear();
    _runningTasks = 0;
  }

  void _startExecution() {
    if (_runningTasks == maxConcurrentTasks || _queue.isEmpty) {
      return;
    }

    while (_isRunTask) {
      _toDo();
    }
  }

  void _toDo() {
    _runningTasks++;
    debugPrint('Concurrent workers: $_runningTasks');

    final q = _queue.removeFirst();
    task(q).then((value) async {
      unawaited(callback(value));
      _runningTasks--;
      debugPrint('Concurrent workers: $_runningTasks');
      if (_isRunTask) {
        _toDo();
      }
    }).catchError((e, s) {
      unawaited(callback(q));
      _runningTasks--;
      debugPrint('Concurrent workers: [ERROR]');
      if (_isRunTask) {
        _toDo();
      }
    });
  }
}
