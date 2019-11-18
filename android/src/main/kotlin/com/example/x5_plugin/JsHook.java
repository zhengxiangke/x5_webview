package com.example.x5_plugin;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.util.Log;
import android.webkit.JavascriptInterface;

import com.tencent.smtt.sdk.WebView;

public class JsHook {

    /**
     * js调用原生的公共入口
     *
     * @param params     传递数据 非必须 ,
     */
//    @SuppressLint("JavascriptInterface")
    @JavascriptInterface
    public void call( final String params) throws Exception {
        Log.e("call", params);
    }
}
