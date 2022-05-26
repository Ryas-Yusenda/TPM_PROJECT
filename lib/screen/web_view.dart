// ignore_for_file: deprecated_member_use
import 'dart:async';

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
  late WebViewController controller;
  final Completer<WebViewController> controllertwo =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    var webView = WebView(
      initialUrl: widget.links,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        controllertwo.complete(controller);
        this.controller = controller;
      },
      onProgress: (url) {
        {
          controller.evaluateJavascript(
              "document.getElementById('parallax1').style.display='none';");
          controller.evaluateJavascript(
              "document.getElementById('impulseadcontainer').style.display='none';");
          controller.evaluateJavascript(
              "document.getElementById('_forkInArticleAdContainer').style.display='none';");
          controller.evaluateJavascript(
              "document.getElementById('animation_container').style.display='none';");
          controller.evaluateJavascript(
              "document.getElementsByTagName('header')[0].style.display='none';");
          controller.evaluateJavascript(
              "document.getElementsByClassName('smartbanner_new')[0].style.display='none';");
          controller.evaluateJavascript(
              "document.getElementsByClassName('detail_text_breadcrumb gtm_breadcrumb_artikel')[0].style.display='none';");
          controller.evaluateJavascript(
              "document.getElementsByClassName('linksisip')[0].style.display='none';");
          controller.evaluateJavascript(
              "document.getElementsByClassName('sisip_embed_sosmed video_detail')[0].style.display='none';");
          controller.evaluateJavascript(
              "document.getElementById('adsuiteScrollAd').style.display='none';");
          controller.evaluateJavascript(
              "function getElementByXpath(path) {return document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;}");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[8]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[9]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[10]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[11]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[12]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[13]').style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[14]').style.display='none';");
          controller.evaluateJavascript(
              "var appBanners = document.getElementsByTagName('span');");
          controller.evaluateJavascript(
              "for (var i = 0; i < appBanners.length; i ++) {appBanners[i].style.display = 'none';}");
          controller.evaluateJavascript(
              "var appBanners = document.getElementsByClassName('box-ads');");
          controller.evaluateJavascript(
              "for (var i = 0; i < appBanners.length; i ++) {appBanners[i].style.display = 'none';}");
          controller.evaluateJavascript(
              "document.getElementsByClassName('linksisip')[1].style.display='none';");
          controller.evaluateJavascript(
              "getElementByXpath('/html/body/main/article/div[15]').style.display='none';");
          controller.evaluateJavascript(
              "var appBanners = document.getElementsByTagName('iframe');");
          controller.evaluateJavascript(
              "for (var i = 0; i < appBanners.length; i ++) {appBanners[i].style.display = 'none';}");
          controller.evaluateJavascript(
              "var appBanners = document.getElementsByTagName('table');");
          controller.evaluateJavascript(
              "for (var i = 0; i < appBanners.length; i ++) {appBanners[i].style.display = 'none';}");
          controller.evaluateJavascript(
              "var appBanners = document.getElementsByTagName('video');");
          controller.evaluateJavascript(
              "for (var i = 0; i < appBanners.length; i ++) {appBanners[i].style.display = 'none';}");
          controller.evaluateJavascript(
              "document.getElementsByTagName('footer')[0].style.display='none';");
          controller.evaluateJavascript("");
          controller.evaluateJavascript("");
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: true,
        actions: const [],
        centerTitle: true,
        elevation: 4,
      ),
      body: webView,
    );
  }
}
