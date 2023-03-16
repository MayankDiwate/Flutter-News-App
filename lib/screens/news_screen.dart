import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.newsUrl});

  final String newsUrl;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 60, width: 150),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: WebViewWidget(
          controller: _controller..loadRequest(Uri.parse(widget.newsUrl)),
        ),
      ),
    );
  }
}
