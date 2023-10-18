/// Export from [network.provider.dart]
///
enum NetworkExceptionType {
  /// The exception for no internet connection.
  noInternet,

  /// The exception for an expired bearer token.
  tokenExpired,

  /// The exception for a failed connection attempt.
  connectTimeout,

  /// The exception for no internet connectivity.
  socket,

  /// A better name for the socket exception.
  fetchData,

  /// The exception for an incorrect parameter in a request/response.
  format,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  serialization,

  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate
  badCertificate,

  /// It was caused by an incorrect status code
  badResponse,

  /// When the request is cancelled will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or Socket Exceptions.
  connectionError,

  /// Default error type, Some other [Error].
  unknown,
}
