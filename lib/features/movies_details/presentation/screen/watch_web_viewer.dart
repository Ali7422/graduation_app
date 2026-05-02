import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WatchWebViewer extends StatefulWidget {
  final String url;
  const WatchWebViewer({super.key, required this.url});

  @override
  State<WatchWebViewer> createState() => _WatchWebViewerState();
}

class _WatchWebViewerState extends State<WatchWebViewer> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
          ],
        ),
      ),
    );
  }
}