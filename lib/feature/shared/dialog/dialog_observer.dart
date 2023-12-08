import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DialogObserver extends ValueNotifier<bool> {
  DialogObserver({bool isLoading = false}) : super(isLoading);

  void _changeState(bool state) {
    if (value != state) {
      value = state;
    }
  }

  /// it's loading
  void showLoading() {
    _changeState(true);
  }

  /// it's idle
  void hideLoading() {
    _changeState(false);
  }
}
