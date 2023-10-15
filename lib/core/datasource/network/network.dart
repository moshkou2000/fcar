import 'dart:async';

import 'network.model.dart';
import 'network_canceltoken.dart';

abstract class INetwork {
  final String baseUrl;
  final Map<String, dynamic> headers = {};

  /// baseUrl = FlavorService.baseUrl
  INetwork({required this.baseUrl});

  Future<NetworkResponse<dynamic>> delete(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  });

  Future<NetworkResponse<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParam,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
    ProgressCallback? progressCallback,
  });

  Future<NetworkResponse<dynamic>> patch(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  });

  Future<NetworkResponse<dynamic>> post(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  });

  Future<NetworkResponse<dynamic>> put(
    String endpoint, {
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
  });

  Future<NetworkResponse<dynamic>> upload(
    String endpoint, {
    required List<Multipart>? files,
    dynamic body,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
    String? fileKey,
  });

  Future<NetworkResponse<dynamic>> download({
    required String url,
    required String savePath,
    int? maxAttempts,
    NetworkCancelToken? cancelToken,
    ProgressCallback? progressCallback,
  });
}
