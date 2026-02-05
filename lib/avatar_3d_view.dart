import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AvatarWebView extends StatefulWidget {
  const AvatarWebView({super.key});

  @override
  State<AvatarWebView> createState() => _AvatarWebViewState();
}

class _AvatarWebViewState extends State<AvatarWebView> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadRequest(Uri.parse('https://tk256ailab.github.io/vrm-viewer/'));
      ..loadRequest(Uri.parse('https://elegant-tanuki-0787ed.netlify.app/'));

    // _controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadFlutterAsset('assets/web/index.html');

    //_initWebView();
  }

  Future<void> _initWebView() async {
    final html = await rootBundle.loadString('assets/web/index.html');

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(
        html,
        baseUrl: 'https://appassets.androidplatform.net/assets/web/',
      );

    if (!mounted) return;

    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return WebViewWidget(controller: _controller!);
  }
}
