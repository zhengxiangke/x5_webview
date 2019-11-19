功能说明


x5腾讯内核的支持
目前Android 已实现桥接 视频播放 相册打开
Ios只支持普通的页面显示

  x5webview 初始化
  ```dart
      ///注意: 需要首先授权存储权限 否则 X5内核加载失败
        X5Plugin.init().then((isOk) {
          x5Init = isOk;
          print(isOk ? "X5内核成功加载" : "X5内核加载失败");
        });
  ```
  提供了三种方式 一般建议第三种
```dart
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
```
一般建议这种方式
```dart
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
      ///桥接名字
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
```
欢迎添加QQ群一起讨论 883130953

创作不易 支持下  本人会持续研发后续版本

<center class="half"><img src="http://chuantu.xyz/t6/703/1574144272x992245926.jpg" width="300" hegiht="200" align=center /><img src="http://chuantu.xyz/t6/703/1574145134x1031866013.jpg" width="300" hegiht="200" align=center /></center>

