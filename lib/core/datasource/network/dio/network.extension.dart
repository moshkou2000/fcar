import 'package:dio/dio.dart';

extension DioExceptionExtension on DioException {
  /// TODO: set the logic based on your backend config
  /// the logic when [isUnauthorized]
  /// true: unauthorized
  /// false: authorized

  NetworkException get networkException {
    final isUnath = response?.statusCode?.isValid == true;
    final skipLogging = response?.statusCode?.skipLogging == true;
    final title = isUnath ? localization.unauthorized.titleCase : null;

    return NetworkException.fromDioException(
      error: this,
      title: title,
      isUnauthorized: isUnath,
      skipLogging: skipLogging,
    );
  }
}

extension ResponseExtension on Response {
  bool get isNotModified => statusCode?.isNotModified == true;
  bool get isOk => statusCode?.isValid == true;

  NetworkException get networkException {
    final isUnath = statusCode?.isUnauthorized == true;
    final title = isUnath ? localization.unauthorized.titleCase : null;

    // TODO: specify [error] & [message]
    throw NetworkException(
      error: null,
      message: '',
      response: this,
      stackTrace: null,
      title: title,
      isUnauthorized: isUnath,
      requestOptions: requestOptions,
      type: DioExceptionType.unknown,
    );
  }
}
