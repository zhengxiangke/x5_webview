package com.example.x5_plugin;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.webkit.JavascriptInterface;

import java.util.HashMap;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

public class JavascriptChannel {
    private String name;
    private MethodChannel mMethodChannel;
    private Context mContext;
    private Handler mHandler;

    public JavascriptChannel(String name, MethodChannel methodChannel, Context context) {
        this.name = name;
        mMethodChannel = methodChannel;
        mContext = context;
    }

    @SuppressLint("JavascriptInterface")
    @JavascriptInterface
    public void call(final String msg) {
        Log.e("call", msg);
        mHandler = new Handler(mContext.getMainLooper());

        mHandler.post(new Runnable() {
            @Override
            public void run() {
                HashMap<String, String> map = new HashMap<>();
                map.put("name", name);
                map.put("msg", msg);
                mMethodChannel.invokeMethod("onJavascriptChannelCallBack", map);
            }
        });

    }

}
