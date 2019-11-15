import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class X5Plugin {
  static const MethodChannel _channel =
      const MethodChannel('x5_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///加载内核，没有内核会自动下载,加载失败会自动调用系统内核
  static Future<bool> init() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      bool res = await _channel.invokeMethod("x5Init");
      return res;
    } else {
      return false;
    }
  }

  ///打开视频浏览器
  static Future<void> openVideo(String url) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final Map<String, dynamic> params = <String, dynamic>{
        'url': url
      };
      return await _channel.invokeMethod("openVideo", params);
    } else {
      return null;
    }
  }
  ///打开简单的x5webview
  static Future<void> openWebActivity(String url, {String title}) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final Map<String, dynamic> params = <String, dynamic>{
        'title': title,
        'url': url
      };
      return await _channel.invokeMethod("openWebActivity", params);
    } else {
      return;
    }
  }
  ///监听android 发给flutter的数据 用于桥接
  static void setMethodCallHandler (Function(String msg) callback) {
    _channel.setMethodCallHandler((handler) => Future<void>(() {
      //监听native发送的方法名及参数
      switch (handler.method) {
        case "bridge":
          //代表webview桥接传过来 具体业务方法在参数的method
//          Map<String, dynamic> json = jsonDecode(handler.arguments);
          callback(handler.arguments);
//          _send(handler.arguments);//handler.arguments表示native传递的方法参数
          break;
      }
    }));
  }


}
