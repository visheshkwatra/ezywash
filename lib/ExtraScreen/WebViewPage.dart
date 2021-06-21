import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

/// It will Opens the EzyWash Website in App
class WebsiteWebView extends StatefulWidget {
  static String id = "WebsiteWebView";

  @override
  _WebsiteWebViewState createState() => _WebsiteWebViewState();
}

class _WebsiteWebViewState extends State<WebsiteWebView> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    /// Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: WebView(
          initialUrl: 'https://ezywash.in/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
