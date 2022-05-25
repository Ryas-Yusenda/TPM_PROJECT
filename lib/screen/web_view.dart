import 'package:news_info/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewModul extends StatefulWidget {
  const WebViewModul({Key? key, required this.links}) : super(key: key);

  final String links;

  @override
  State<WebViewModul> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewModul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: true,
          actions: const [],
          centerTitle: true,
          elevation: 4,
        ),
        body: WebView(
          initialUrl: widget.links,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
