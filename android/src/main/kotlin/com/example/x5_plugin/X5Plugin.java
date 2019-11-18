package com.example.x5_plugin;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.tencent.smtt.sdk.QbSdk;
import com.tencent.smtt.sdk.TbsVideo;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class X5Plugin implements MethodChannel.MethodCallHandler {
    private Context mContext;
    public static MethodChannel  channel;
    public X5Plugin(Context context) {
        mContext = context;
    }


    public static void registerWith(PluginRegistry.Registrar registrar) {

         channel = new MethodChannel(registrar.messenger(), "x5_plugin");
        channel.setMethodCallHandler(new X5Plugin(registrar.context()));
        //设置标识
        registrar.platformViewRegistry().registerViewFactory("com.example/x5Plugin", new X5WebViewFactory(registrar.messenger(), registrar.activeContext()));

    }

    //调用flutter端方法，无返回值

    public static void sendFlutter(String method, Object o) {
        channel.invokeMethod(method, o);
    }
    //调用flutter端方法，有返回值
    public static void sendFlutter(String method, Object o, MethodChannel.Result result) {
        channel.invokeMethod(method, o, result);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, final MethodChannel.Result result) {
        if (methodCall.method .equals("getPlatformVersion") ) {
            result.success("Android ${android.os.Build.VERSION.RELEASE}");
        } else if (methodCall.method .equals("x5Init") ) {
            //搜集本地tbs内核信息并上报服务器，服务器返回结果决定使用哪个内核。

            QbSdk.PreInitCallback cb = new QbSdk.PreInitCallback() {

                @Override
                public void onViewInitFinished(boolean arg0) {
                    // TODO Auto-generated method stub
                    //x5內核初始化完成的回调，为true表示x5内核加载成功，否则表示x5内核加载失败，会自动切换到系统内核。
                    Log.d("app", " onViewInitFinished is " + arg0);
                    result.success(arg0);
                }

                @Override
                public void onCoreInitFinished() {
                    // TODO Auto-generated method stub
                    Log.d("app", " onViewInitFinished is " );
                }
            };
            //x5内核初始化接口
            QbSdk.initX5Environment(mContext,  cb);
        } else if (methodCall.method .equals("openVideo")) {
            //打开播放视频
            String url = methodCall.argument("url");
            TbsVideo.openVideo(mContext, url, null);
            result.success(null);
        } else if (methodCall.method.equals("openWebActivity")) {
            //打开一个简单的webview
            String url = methodCall.argument("url");
            Intent intent = new Intent(mContext, BrowserActivity.class);
            intent.putExtra("url", url);
            mContext.startActivity(intent);
        } else if (methodCall.method .equals("openFilechooserActivity")) {
            //打开一个支持图片上传的页面
            String url = methodCall.argument("url");
            Intent intent = new Intent(mContext, FilechooserActivity.class);
            intent.putExtra("url", url);
            mContext.startActivity(intent);
        }else {
            result.notImplemented();
        }
    }

}