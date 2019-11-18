import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x5_plugin/x5_webview.dart';
class Demo extends StatefulWidget {
  String url;

  Demo(this.url);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  X5WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: Text("webview实例")),
      body:  X5Webview(url: widget.url,
      onPageFinished: (String url) async{
//        var url = await _controller.currentUrl();
//        print(url);

        var listName = ["X5Web"];
        _controller.addJavascriptChannels(listName,
                (name, data) {
              switch (name) {
                case "X5Web":
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("获取到的字符串为："),
                          content: Text(data),
                        );
                      });
                  break;
                case "Toast":
                  print(data);
                  break;
              }
            });
      },
      onWebViewCreated:(X5WebViewController controller) {
        _controller = controller;
      } ,)
    );
  }
}
