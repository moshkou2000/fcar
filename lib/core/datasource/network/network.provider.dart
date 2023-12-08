import 'package:fcar_lib/core/datasource/network/network.dart';
import 'package:fcar_lib/core/datasource/network/dio/dio.dart';

import '../../../config/flavor.dart';

final INetwork network = DioNetwork(baseUrl: Flavor.baseUrl, database: null);
