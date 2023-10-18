/// Export from [network.provider.dart]
///
import 'dart:io';

extension HttpStatusExtension on num? {
  /// TODO: set the logic based on your backend config
  /// the logic when [isUnauthorized]
  /// true: unauthorized
  /// false: authorized
  /// status code 401
  bool get isUnauthorized => this == HttpStatus.unauthorized;

  /// status code 304
  bool get isNotModified => this == HttpStatus.notModified;

  /// status code is 200..299 or 304
  bool get isValid =>
      this != null && (this == 304 || (this! >= 200 && this! < 300));

  /// skip logging for the folowing condition
  bool get skipLogging =>
      this != null && ([4, 5].contains(this! ~/ 100)) ||
      this == HttpStatus.unauthorized;
}
