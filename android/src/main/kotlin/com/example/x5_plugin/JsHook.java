package com.example.x5_plugin;

import android.app.Activity;
import android.webkit.JavascriptInterface;

import com.tencent.smtt.sdk.WebView;

public class JsHook {
    private Activity mActivity;
    private WebView mWebView;

    public JsHook(Activity activity, WebView webView) {
        mActivity = activity;
        mWebView = webView;
    }

    /**
     * js调用原生的公共入口
     *
     * @param params     传递数据 非必须 ,
     * @param callbackId 标识  非必须 默认传0
     */
    @JavascriptInterface
    public void call( final String params, final int callbackId) throws Exception {
        mActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                X5Plugin.sendFlutter("bridge",params);
            }
        });
    }
}
