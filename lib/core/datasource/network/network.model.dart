/// Export from [network.provider.dart]
///
import 'dart:convert';
import 'dart:io';

import 'network.enum.dart';

/// The type of a progress listening callback when sending or receiving data.
///
/// [count] is the length of the bytes have been sent/received.
/// [total] is the content length of the response/request body.
/// 1. When sending data, [total] is the request body length.
/// 2. When receiving data, [total] will be -1 if the size of the response body,
///    typically with no `content-length` header.
typedef ProgressCallback = void Function(int count, int total);

/// The [NetworkResponse] class contains the payload (could be transformed)
/// that respond from the request, and other information of the response.
abstract class NetworkResponse<T> {
  /// The [NetworkRequestOptions] used for the corresponding request.
  final NetworkRequestOptions requestOptions;

  /// The response payload in specific type.
  final T? data;

  /// The HTTP status code for the response.
  final int? statusCode;

  /// Returns the reason phrase associated with the status code.
  final String? statusMessage;

  /// Headers for the response.
  final Map<String, dynamic> header;

  /// An extra map that you can save your custom information in.
  final Map<String, dynamic> extra;

  @override
  String toString() {
    if (data is Map) {
      // Log encoded maps for better readability.
      return json.encode(data);
    }
    return data.toString();
  }

  NetworkResponse({
    required this.requestOptions,
    this.data,
    this.statusCode,
    this.statusMessage,
    Map<String, dynamic>? extra,
    Map<String, List<String>>? header,
  })  : header = header ?? <String, List<String>>{},
        extra = extra ?? <String, dynamic>{};
}

/// The internal request option class
abstract class NetworkRequestOptions {
  final String path;
  final String baseUrl;
  final String method;
  final dynamic data;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? extra;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
  final Duration? sendTimeout;
  final Duration? receiveTimeout;
  final Duration? connectTimeout;
  final String? contentType;
  final StackTrace? sourceStackTrace;

  const NetworkRequestOptions({
    required this.path,
    required this.baseUrl,
    required this.method,
    this.data,
    this.headers,
    this.queryParameters,
    this.extra,
    this.onSendProgress,
    this.onReceiveProgress,
    this.sendTimeout,
    this.receiveTimeout,
    this.connectTimeout,
    this.contentType,
    this.sourceStackTrace,
  });
}

/// A file to be uploaded as part of a [Multipart Request].
/// Multipart is based on stream, and a stream can be read only once
abstract class Multipart {
  final File file;

  /// The basename of the file. May be null.
  final String filename;

  /// The content-type of the file. Defaults to `application/octet-stream`.
  final NetworkContentType? contentType;

  /// The additional headers the file has. May be null.
  final Map<String, List<String>>? headers;

  /// Creates a new [Multipart] from a chunked [Stream] of bytes. The length
  /// of the file in bytes must be known in advance.
  ///
  /// [contentType] currently defaults to `application/octet-stream`, but in the
  /// future may be inferred from [filename].
  const Multipart({
    required this.file,
    required this.filename,
    this.contentType,
    this.headers,
  });

  Stream<List<int>> getStreamFromFile() {
    final stream = file.openRead();
    return stream;
  }
}
