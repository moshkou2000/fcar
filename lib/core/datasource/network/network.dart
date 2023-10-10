import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../config/constant/value.constant.dart';
import '../../extension/string.extension.dart';
import 'network.extension.dart';
import 'network_interceptor.dart';
import 'network_logger_interceptor.dart';

Network network = Network();

const int _maxSize = 118000000; // 118 MB
const int _maxEntrySize = 11800000; // 11.8 MB

class Network {
  late final CacheStore cacheStore;
  late final CacheOptions cacheOptions;
  late final Dio dio;

  Network() {
    cacheStore = MemCacheStore(maxSize: _maxSize, maxEntrySize: _maxEntrySize);
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
        NetworkInterceptor(),
        NetworkLoggerInterceptor(),
        DioCacheInterceptor(options: cacheOptions),
      ]);
  }
}
