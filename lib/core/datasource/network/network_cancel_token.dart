import 'package:dio/dio.dart';

class NetworkCancelToken {
  /// all CancelToken
  /// naming: use API method + name

  static CancelToken getACB = CancelToken();
  static CancelToken postACB = CancelToken();
  static CancelToken deleteACB = CancelToken();

  /// cancel api request from [service]

  static void cancelGetACB() => _cancel(getACB);
  static void cancelPostACB() => _cancel(postACB);
  static void cancelDeleteACB() => _cancel(deleteACB);

  static void _cancel(CancelToken token) {
    if (!token.isCancelled) {
      token.cancel();
      token = CancelToken();
    }
  }
}
