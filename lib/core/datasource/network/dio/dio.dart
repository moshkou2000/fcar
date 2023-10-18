import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:retry/retry.dart';

import '../../../../config/constant/value.constant.dart';
import '../network.enum.dart';
import '../network.extension.dart';
import '../network.model.dart' as model;
import '../network.dart';
import '../network_canceltoken.dart';
import '../network_exception.dart';
import 'cache/dio_cache.dart.dart';
import 'dio.model.dart';
import 'interceptor/dio_logger_interceptor.dart';
import 'interceptor/dio_validator_interceptor.dart';

class DioNetwork implements INetwork {
  _DioNetwork network = _DioNetwork();

  DioNetwork({required this.baseUrl});

  @override
  String baseUrl;

  @override
  Map<String, dynamic> headers = {
    HttpHeaders.contentTypeHeader: NetworkContentType.applicationJson.name,
  };

  @override
  NetworkCancelToken get newCancelToken => DioCancelToken();

  @override
  Future<model.NetworkResponse<dynamic>> delete(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  }) async {
    final response = await retry(
      () => network.dio
          .deleteUri(
            Uri.https(
              baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: headers),
            cancelToken: cancelToken as DioCancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParam,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
    ProgressCallback? progressCallback,
  }) async {
    final response = await retry(
      () => network.dio
          .getUri(
            Uri.https(
              baseUrl,
              endpoint,
              queryParam,
            ),
            options: Options(headers: headers),
            cancelToken: cancelToken as DioCancelToken,
            onReceiveProgress: progressCallback,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> patch(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  }) async {
    final response = await retry(
      () => network.dio
          .patchUri(
            Uri.https(
              baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: headers),
            cancelToken: cancelToken as DioCancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> post(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  }) async {
    final response = await retry(
      () => network.dio
          .postUri(
            Uri.https(
              baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: headers),
            cancelToken: cancelToken as DioCancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> put(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  }) async {
    final response = await retry(
      () => network.dio
          .putUri(
            Uri.https(
              baseUrl,
              endpoint,
            ),
            data: body,
            options: Options(headers: headers),
            cancelToken: cancelToken as DioCancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> upload(
    String endpoint, {
    required List<model.Multipart>? files,
    body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
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
    final h = Map<String, String?>.from(headers);
    h[HttpHeaders.contentTypeHeader] =
        NetworkContentType.multiPartFormData.name;
    h[HttpHeaders.acceptHeader] = NetworkContentType.multiPartFormData.name;

    final response = await retry(
      () => network.dio
          .postUri(
            Uri.https(
              baseUrl,
              endpoint,
            ),
            data: formData,
            options: Options(headers: h),
            cancelToken: cancelToken as DioCancelToken,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? ValueConstant.defaultMaxAttemptsAPI,
    );
    return response as DioResponse;
  }

  @override
  Future<model.NetworkResponse<dynamic>> download({
    required String url,
    required String savePath,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
    ProgressCallback? progressCallback,
  }) async {
    final response = await retry(
      () async => await network.dio
          .download(
            url,
            savePath,
            options: Options(
              headers: headers,
              receiveTimeout:
                  const Duration(seconds: ValueConstant.receiveTimeout),
            ),
            // [deleteOnError] false will allow to cancel the download,
            // and left the incomplete file in the user’s storage
            // deleteOnError: false,
            cancelToken: cancelToken as DioCancelToken,
            onReceiveProgress: progressCallback,
          )
          .timeout(const Duration(seconds: ValueConstant.connectTimeout)),
      retryIf: (e) => _retryLogic(e),
      maxAttempts: maxAttempts ?? 8,
    );
    return response as DioResponse;
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

class _DioNetwork {
  late final CacheStore cacheStore;
  late final CacheOptions cacheOptions;
  late final Dio dio;

  static final _DioNetwork _network = _DioNetwork._internal();
  factory _DioNetwork() => _network;
  _DioNetwork._internal() {
    // final int _maxSize = 118000000; // 118 MB
    // final int _maxEntrySize = 11800000; // 11.8 MB
    // cacheStore = MemCacheStore(maxSize: _maxSize, maxEntrySize: _maxEntrySize);
    cacheStore = DioCache();
    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      priority: CachePriority.normal,

      /// configure the system to use cached data for specific status codes or,
      /// if you don't specify any, for all status codes.
      hitCacheOnErrorExcept: [HttpStatus.unauthorized, HttpStatus.forbidden],
      // maxStale: const Duration(minutes: 5),
      // keyBuilder: (request) {
      //   request.path.alphanumeric;
      //   return request.uri.toString();
      // },
      allowPostMethod: false,
    );

    dio = Dio(BaseOptions(
      responseType: ResponseType.json,
      connectTimeout:
          const Duration(milliseconds: ValueConstant.connectTimeout),
      receiveTimeout:
          const Duration(milliseconds: ValueConstant.receiveTimeout),
      sendTimeout: const Duration(milliseconds: ValueConstant.sendTimeout),
      validateStatus: (int? status) => status?.isValid == true,
    ))
      ..interceptors.addAll([
        DioLoggerInterceptor(),
        DioValidatorInterceptor(),
        DioCacheInterceptor(options: cacheOptions),
      ]);
  }
}
