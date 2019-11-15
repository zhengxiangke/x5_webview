import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:x5_plugin/x5_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool x5Init ;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    X5Plugin.setMethodCallHandler((String msg) {
      print(msg);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await X5Plugin.platformVersion;
      X5Plugin.init().then((isOk) {
        x5Init = isOk;
        print(isOk ? "X5内核成功加载" : "X5内核加载失败");
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              X5Plugin.openWebActivity("file:///android_asset/webpage/demo.html");
            },
            child: Text(x5Init.toString()),
          ),
        ),
      ),
    );
  }
}
