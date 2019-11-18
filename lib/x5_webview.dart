import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
typedef void PageFinishedCallback(String url);
typedef void MessageReceived(String name, String data);
typedef void X5WebViewCreatedCallback(X5WebViewController controller);
class X5Webview extends StatefulWidget {
  String url;
  final PageFinishedCallback onPageFinished;
  final X5WebViewCreatedCallback onWebViewCreated;

  X5Webview({this.url, this.onPageFinished, this.onWebViewCreated});

  @override
  _X5WebviewState createState() => _X5WebviewState();
}

class _X5WebviewState extends State<X5Webview> {
  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.android ?
    AndroidView(
      viewType: 'com.example/x5Plugin',
      ///通信MethodChannel
      onPlatformViewCreated: (int id) {
        _onPlatformViewCreated(id);
      },
      /// 参数的编码方式
      creationParamsCodec: const StandardMessageCodec(),
      ///传入native 的地址
      creationParams: widget.url,
    ) : WebView(
      initialUrl: widget.url,
      ///ios 不支持桥接  只支持普通的页面显示
    );
  }
  void _onPlatformViewCreated(int id) {
    if (widget.onWebViewCreated == null) {
      return;
    }
    final X5WebViewController controller = X5WebViewController._(id, widget);
    widget.onWebViewCreated(controller);
  }
}

class X5WebViewController {
  X5Webview _widget;
  X5WebViewController._(
      int id,
      this._widget,
      ) : _channel = MethodChannel('com.example/x5Plugin_$id') {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  final MethodChannel _channel;

  Future<void> addJavascriptChannels(
      List<String> names, MessageReceived callback) async {
    assert(names != null);
    _channel.setMethodCallHandler((call) {
      if (call.method == "onJavascriptChannelCallBack") {
        Map arg = call.arguments;
        callback(arg["name"], arg["msg"]);
      }
      return;
    });
    await _channel.invokeMethod("addJavascriptChannels", {'names': names});
    return;

  }
  Future _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onPageFinished":
        if (_widget.onPageFinished != null) {
          _widget.onPageFinished(call.arguments);
        }
        break;

      default:
        throw MissingPluginException(
            '${call.method} was invoked but has no handler');
        break;
    }
  }
}
