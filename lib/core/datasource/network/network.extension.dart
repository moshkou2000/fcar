import 'dart:io';

import 'package:dio/dio.dart';

import '../../../shared/domain/provider/localization/localization.dart';
import '../../extension/string.extension.dart';
import 'network_exception.dart';

extension NumberExtension on num? {
  /// TODO: set the logic based on your backend config
  /// the logic when [isUnauthorized]
  /// true: unauthorized
  /// false: authorized
  // status code 401
  bool get isUnauthorized => this == HttpStatus.unauthorized;
  // status code 304
  bool get isNotModified => this == HttpStatus.notModified;
  // status code is 200..299 or 304
  bool get isValid =>
      this != null && (this == 304 || (this! >= 200 && this! < 300));
}

extension DioExceptionExtension on DioException {
  /// TODO: set the logic based on your backend config
  /// the logic when [isUnauthorized]
  /// true: unauthorized
  /// false: authorized

  NetworkException get networkException {
    final isUnath = response?.statusCode?.isValid == true;
    final title = isUnath ? localization.unauthorized.titleCase : null;

    return NetworkException.fromDioException(
      error: this,
      title: title,
      isUnauthorized: isUnath,
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
