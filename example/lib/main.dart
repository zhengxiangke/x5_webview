import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:x5_plugin/x5_plugin.dart';

import 'demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool x5Init;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {

      ///需要首先授权存储权限 否则 X5内核加载失败
      X5Plugin.init().then((isOk) {
        x5Init = isOk;
        print(isOk ? "X5内核成功加载" : "X5内核加载失败");
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {

              X5Plugin.openFilechooserActivity("file:///android_asset/webpage/fileChooser.html",
                  title: "xx");
            },
            child: Container(
              child: Text("支持打开相册页面 支持视频 不支持桥接"),
              width: 150,
              height: 150,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
//
              X5Plugin.openWebActivity("https://www.youku.com/", title: "xx");
            },
            child: Container(
              child: Text("支持视频 不支持桥接和相册"),
              width: 150,
              height: 150,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 30,),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Demo("file:///android_asset/webpage/demo.html")),
              );
            },
            child: Container(
              child: Text("支持 桥接 视频  不支持相册(一般建议用这个 这个实用)"),
              width: 150,
              height: 150,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
