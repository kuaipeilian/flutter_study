import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KPLWebViewPage extends StatefulWidget {
  final String url;
  KPLWebViewPage({this.url = 'https://www.kuaipeilian.com'});

  @override
  _KPLWebViewPageState createState() => _KPLWebViewPageState();
}

class _KPLWebViewPageState extends State<KPLWebViewPage> {
  WebViewController _controller;
  String _title = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return WebView(
              initialUrl: widget.url,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                _getDocumentTitle();
              },
            );
          },
        ));
  }
  void _getDocumentTitle() async {
    if (_controller != null) {
      String title =  await _controller.evaluateJavascript('document.title');
      if (Platform.isAndroid && title.length >= 2) {
        title = title.substring(1, title.length - 1);
      }
      setState(() {
        _title = title;
      });
    }
  }
  // 向js 注入方法 目前可以不需要
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
