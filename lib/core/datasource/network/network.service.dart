import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../config/constant/value.constant.dart';
import '../../flavor/flavor.service.dart';
import 'network.dart';
import 'network_exception.dart';

class NetworkService {
  static const String _jsonContentType = 'application/json';
  static const String _multiPartFormDataType = 'multipart/form-data';

  final String _baseUrl = FlavorService.baseUrl;
  final Map<String, String?> _headers = {
    HttpHeaders.contentTypeHeader: _jsonContentType,
  };

  Future<Response<dynamic>> delete(
    String endpoint, {
    dynamic body,
    CancelToken? cancelToken,
    int? maxAttempts,
  }) async {
    final response = await retry(
      () => network.dio
          .deleteUri(
            Uri.https(
              _baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: _headers),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  // Future<void> _getCache({required Response response}) async {
  //   // eTag
  //   if (response.etag?.isNotEmpty == true) {
  //     final eTags =
  //         await _keystore.read<Map<String, String>?>(key: KeystoreKey.eTag);
  //     if (eTags?.containsKey(response.requestOptions.path.alphanumeric) ==
  //         true) {}
  //   }
  // }

  /// eTag:
  Future<Response<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParam,
    CancelToken? cancelToken,
    int? maxAttempts,
    bool? eTag = true,
  }) async {
    final h = Map<String, String?>.from(_headers);
    // if (eTag == true) {
    //   h[HttpHeaders.ifNoneMatchHeader] = cachedETag ?? '';
    // }

    final response = await retry(
      () => network.dio
          .getUri(
            Uri.https(
              _baseUrl,
              endpoint,
              queryParam,
            ),
            options: Options(headers: h),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  Future<Response<dynamic>> patch(
    String endpoint, {
    dynamic body,
    CancelToken? cancelToken,
    int? maxAttempts,
  }) async {
    final response = await retry(
      () => network.dio
          .patchUri(
            Uri.https(
              _baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: _headers),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  Future<Response<dynamic>> post(
    String endpoint, {
    dynamic body,
    CancelToken? cancelToken,
    int? maxAttempts,
  }) async {
    final response = await retry(
      () => network.dio
          .postUri(
            Uri.https(
              _baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: _headers),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  Future<Response<dynamic>> put(
    String endpoint, {
    dynamic body,
    CancelToken? cancelToken,
    int? maxAttempts,
  }) async {
    final response = await retry(
      () => network.dio
          .putUri(
            Uri.https(
              _baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: _headers),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  Future<Response<dynamic>> upload(
    String endpoint, {
    required List<MultipartFile>? files,
    dynamic body,
    CancelToken? cancelToken,
    int? maxAttempts,
    String? fileKey,
  }) async {
    final dataMap = <String, dynamic>{};

    if (body != null) {
      dataMap.addAll(body);
    }

    if (files?.isNotEmpty == true) {
      if (files?.length == 1) {
        dataMap.addAll({
          fileKey ?? 'file': files!.first,
        });
      } else {
        dataMap.addAll({
          fileKey ?? 'files': files,
        });
      }
    }

    final formData = FormData.fromMap(dataMap);
    final h = Map<String, String?>.from(_headers);
    h[HttpHeaders.contentTypeHeader] = _multiPartFormDataType;
    h[HttpHeaders.acceptHeader] = _multiPartFormDataType;

    final response = await retry(
      () => network.dio
          .postUri(
            Uri.https(
              _baseUrl,
              endpoint,
            ),
            data: formData,
            options: Options(headers: h),
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response;
  }

  Future<Response<dynamic>> download({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    int? maxAttempts,
    ProgressCallback? progressCallback,
  }) async {
    final response = await retry(
      () async => await network.dio
          .download(
            url,
            savePath,
            options: Options(
              headers: _headers,
              receiveTimeout:
                  const Duration(seconds: ValueConstant.receiveTimeout),
            ),
            // [deleteOnError] false will allow to cancel the download,
            // and left the incomplete file in the user’s storage
            // deleteOnError: false,
            cancelToken: cancelToken,
            onReceiveProgress: progressCallback,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? 8,
    );
    return response;
  }

  bool _retryLogic(Exception e) {
    // // TODO: set the logic
    // return false;
    // true when it
    // IS socket OR timeout,
    // AND NOT cancel OR Kickout
    return e is SocketException ||
        e is TimeoutException ||
        (e is NetworkException && !e.isCanceled && !e.isUnauthorized);
  }
}
