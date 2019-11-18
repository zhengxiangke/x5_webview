
x5腾讯内核的支持 目前Android 已实现桥接 视频播放 相册打开  Ios只支持普通的页面显示
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
```