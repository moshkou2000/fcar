/// Export from [network.provider.dart]
///
import 'package:dio/dio.dart';

import '../../../shared/domain/provider/localization/localization.dart';

class NetworkException extends DioException {
  String title;
  bool isUnauthorized;
  bool skipLogging;

  bool get isCanceled => type == DioExceptionType.cancel;

  NetworkException({
    required super.requestOptions,
    super.error,
    super.message,
    super.response,
    super.stackTrace,
    super.type = DioExceptionType.unknown,
    this.isUnauthorized = false,
    this.skipLogging = false,
    String? title,
  }) : title = title ?? localization.error;

  factory NetworkException.fromDioException({
    required DioException error,
    required bool isUnauthorized,
    required bool skipLogging,
    String? title,
  }) {
    final e = error as NetworkException;
    e.title = title ?? localization.error;
    e.isUnauthorized = isUnauthorized;
    e.skipLogging = skipLogging;
    return e;
  }

  @override
  String toString() => 'NetworkException('
      'title: $title,'
      'message: $message,'
      'code: ${response?.statusCode ?? ''},'
      'type: ${type.name},'
      'isUnauthorized: $isUnauthorized,'
      'path: ${requestOptions.path},'
      '${requestOptions.data != null ? 'data: ${requestOptions.data},' : ''}'
      '${requestOptions.extra.isNotEmpty ? 'extra: ${requestOptions.extra},' : ''}'
      '${requestOptions.queryParameters.isNotEmpty ? 'queryParameters: ${requestOptions.queryParameters},' : ''}'
      ')';
}

class InternetException implements Exception {
  @override
  String toString() => localization.noInternet;
}
