import '../../flavor/flavor.service.dart';
import 'dio/dio.dart';
import 'network.dart';

export 'deserialize.dart';
export 'url.constant.dart';

final INetwork network = DioNetwork(baseUrl: FlavorService.baseUrl);
