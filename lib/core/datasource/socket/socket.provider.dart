import 'package:fcar_lib/core/datasource/socket/socket.dart';
import 'package:fcar_lib/core/datasource/socket/socketio/socketio.dart';

import '../../../config/flavor.dart';

final ISocket socket = Socketio(socketUrl: Flavor.socketUrl);
