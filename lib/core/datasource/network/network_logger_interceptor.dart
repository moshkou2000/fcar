import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network.extension.dart';

class NetworkLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if (kDebugMode) _logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // if (kDebugMode) _logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) _logError(err);
    throw err.networkException;
  }

  void _logError(DioException err) {
    try {
      log(_getRequest(err.requestOptions), name: 'error', error: err);
      if (err.response != null) log(_getResponse(err.response!), name: 'error');
    } catch (err) {
      log('unable to create a CURL representation of the error');
    }
  }

  void _logResponse(Response response) {
    try {
      log(_getResponse(response), name: 'response');
    } catch (err) {
      log('unable to create a CURL representation of the response');
    }
  }

  void _logRequest(RequestOptions requestOptions) {
    try {
      log(_getRequest(requestOptions), name: 'request');
    } catch (err) {
      log('unable to create a CURL representation of the requestOptions');
    }
  }

  String _getRequest(RequestOptions options) {
    final components = <String>['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData) {
        options.data = Map.fromEntries(options.data.fields);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }

  String _getResponse(Response response) {
    final components = <String>['curl -i'];
    components.add('-Code ${response.statusCode}');
    components.add('-Message ${response.statusMessage}');

    response.extra.forEach((k, v) {
      components.add('-EXTRA "$k: $v"');
    });

    response.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (response.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (response.data is FormData) {
        response.data = Map.fromEntries(response.data.fields);
      }

      final data = json.encode(response.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    return components.join(' \\\n\t');
  }
}
