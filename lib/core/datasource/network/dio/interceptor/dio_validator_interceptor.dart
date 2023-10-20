import 'package:dio/dio.dart';

import '../dio.extension.dart';

class DioValidatorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// [checkResponse] may throw an exception
    _checkResponse(response, handler);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw err.networkException;
  }

  void _checkResponse(Response response, ResponseInterceptorHandler handler) {
    if (!response.isOk) {
      throw response.networkException;
    }
  }
}
