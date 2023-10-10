import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'dialog.enum.dart';

/// handle [_DialogComponent] state which is [DialogState.loading] and [DialogState.idle]
/// [DialogState.loading] will replace primary CTA button text to circular progress indicator
/// and disable the button
class DialogObserver extends ValueNotifier<DialogState> {
  DialogObserver({DialogState? value}) : super(value ?? DialogState.idle);

  void _changeState(DialogState state) {
    if (value != state) {
      value = state;
    }
  }

  /// change the dialog state to [loading]
  void showLoading() {
    _changeState(DialogState.loading);
  }

  /// change the dialog state to [idle]
  void hideLoading() {
    _changeState(DialogState.idle);
  }
}
