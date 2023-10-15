/// Controls cancellation of requests.
///
/// The same token can be shared between different requests.
/// When [cancel] is invoked, requests bound to this token will be cancelled.
abstract class NetworkCancelToken {
  void cancel([Object? reason]);
}
