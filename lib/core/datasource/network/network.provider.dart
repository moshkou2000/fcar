import '../../flavor/flavor.service.dart';
import 'dio/dio.dart';
import 'dio/dio.model.dart';
import 'network.dart';
import 'network_canceltoken.dart';

class NetworkProvider {
  late final INetwork network;

  NetworkProvider() {
    _createSecureStorage();
  }

  NetworkCancelToken get newCancelToken => DioCancelToken();

  void _createSecureStorage() {
    network = DioNetwork(baseUrl: FlavorService.baseUrl);
  }
}
