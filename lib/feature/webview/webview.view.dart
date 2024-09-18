import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview.argument.dart';

class WebviewView extends ConsumerStatefulWidget {
  const WebviewView({required this.arguments, super.key});

  final WebviewArgument arguments;

  @override
  ConsumerState<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends ConsumerState<WebviewView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final WebViewController _controller =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());
  int _loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    _controller
      ..loadRequest(widget.arguments.url)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _loadingPercentage = 0);
          },
          onProgress: (int progress) {
            setState(() => _loadingPercentage = progress);
          },
          onPageFinished: (String url) {
            setState(() => _loadingPercentage = 100);
          },
          onNavigationRequest: (NavigationRequest request) {
            return widget.arguments.onNavigationRequest?.call(request.url) ??
                NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            widget.arguments.onUrlChange?.call(change.url);
          },
          onWebResourceError: (WebResourceError error) {
            widget.arguments.onError?.call();
          },
          onHttpError: (HttpResponseError error) {
            widget.arguments.onError?.call();
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(title: widget.arguments.title),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      actions: [
        if (widget.arguments.hasCloseButton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          )
      ],
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(title),
    );
  }

  Widget? _buildBody() {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_loadingPercentage < 100)
          Center(
            child: CircularProgressIndicator(value: _loadingPercentage / 100.0),
          ),
      ],
    );
  }
}
