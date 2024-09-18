import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

class WebviewArgument {
  final String title;
  final Uri url;
  final FutureOr<NavigationDecision> Function(String? url)? onNavigationRequest;
  final void Function(String? url)? onUrlChange;
  final void Function()? onError;
  final bool hasCloseButton;

  WebviewArgument({
    required this.title,
    required this.url,
    this.onNavigationRequest,
    this.onUrlChange,
    this.onError,
    this.hasCloseButton = true,
  });
}
