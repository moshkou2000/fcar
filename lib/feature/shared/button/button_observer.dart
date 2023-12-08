import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'button.enum.dart';

class ButtonObserver extends ValueNotifier<ButtonState> {
  ButtonObserver({ButtonState state = ButtonState.idle}) : super(state);

  void setIdle() => _changeState(ButtonState.idle);
  void setLoading() => _changeState(ButtonState.loading);
  void setDisabled() => _changeState(ButtonState.disabled);
  // void setSuccess() => _changeState(ButtonState.success);
  // void setFailed() => _changeState(ButtonState.failed);

  void _changeState(ButtonState state) {
    if (value != state) {
      value = state;
    }
  }
}
