import 'package:dio/dio.dart';

import '../../../shared/domain/repository/keystore/keystore.enum.dart';
import '../../extension/string.extension.dart';
import '../keystore/keystore.provider.dart';
import 'network.extension.dart';

class NetworkInterceptor extends Interceptor {
  final KeystoreService _keystore = KeystoreService();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// [checkResponse] may throw an exception
    _checkResponse(response, handler);

    /// set chache when there is no error
    _setCache(response: response);
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

  /// For each chache item,
  /// manage the [ResponseExtension] & [KeystoreKey]
  Future<void> _setCache({required Response response}) async {
    networkCache.setETag(
        key: response.requestOptions.path.alphanumeric, value: response.etag);

    // eTag
    if (response.etag?.isNotEmpty == true) {
      var eTags =
          await _keystore.read<Map<String, String>?>(key: KeystoreKey.eTag);
      if (eTags != null) {
        final eTag = eTags[response.requestOptions.path.alphanumeric];
        if (eTag != null) {
          eTags[response.requestOptions.path.alphanumeric] = response.etag!;
        } else {
          eTags.addAll(
              {response.requestOptions.path.alphanumeric: response.etag!});
        }
      } else {
        eTags = {response.requestOptions.path.alphanumeric: response.etag!};
      }

      _keystore.save(key: KeystoreKey.eTag, value: eTags);
    }
  }
}
