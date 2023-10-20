import '../../config/flavor.dart';
import 'network/dio/dio.dart';
import 'network/network.dart';

export 'network/deserialize.dart';
export 'network/url.constant.dart';
export 'network/network.extension.dart';
export 'network/network.model.dart';
export 'network/network_exception.dart';
export 'network/network_exception.enum.dart';

final INetwork network = DioNetwork(baseUrl: Flavor.baseUrl);
