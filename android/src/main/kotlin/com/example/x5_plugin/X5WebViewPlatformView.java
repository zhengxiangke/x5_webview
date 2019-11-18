package com.example.x5_plugin;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.view.View;

import com.example.x5_plugin.utils.X5WebView;
import com.tencent.smtt.export.external.interfaces.WebResourceRequest;
import com.tencent.smtt.sdk.ValueCallback;
import com.tencent.smtt.sdk.WebChromeClient;
import com.tencent.smtt.sdk.WebSettings;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebViewClient;

import java.util.List;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class X5WebViewPlatformView implements PlatformView, MethodChannel.MethodCallHandler {
    private WebView mX5WebView;
    private Context mContext;
    private String mUrl;
    private BinaryMessenger mMessenger;
    private MethodChannel channel;
    private ValueCallback<Uri> uploadFile;
    private ValueCallback<Uri[]> uploadFiles;

    public X5WebViewPlatformView(Context context, int id, String url, BinaryMessenger messenger) {
        mContext = context;
        mUrl = url;
        mMessenger = messenger;
        mX5WebView = new WebView(mContext);
        WebSettings webSetting = mX5WebView.getSettings();
        webSetting.setJavaScriptEnabled(true);
        webSetting.setDomStorageEnabled(true);

         channel = new MethodChannel(messenger, "com.example/x5Plugin_" + id);
        channel.setMethodCallHandler(this);
        mX5WebView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView webView, String url) {
                super.onPageFinished(webView, url);
                channel.invokeMethod("onPageFinished", url);
            }
            /**
             * 防止加载网页时调起系统浏览器
             */
            @Override
            public boolean shouldOverrideUrlLoading(WebView webView, String url) {
                webView.loadUrl(url);
                return true;
            }
            /**
             * 防止加载网页时调起系统浏览器
             */
            @Override
            public boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
                webView.loadUrl(webResourceRequest.getUrl().toString());
                return true;
            }
        });
        //flutter 传过来的参数
        mX5WebView.loadUrl(mUrl);
    }


    @Override
    public View getView() {
        return mX5WebView;
    }

    @Override
    public void dispose() {
        mX5WebView.destroy();
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

        if (methodCall.method .equals("addJavascriptChannels") ) {
            //桥接名字
            List<String> names = methodCall.argument("names");
            for(String name : names){
                Log.e("onMethodCall", name);
                mX5WebView.addJavascriptInterface(new JavascriptChannel(name, channel, mContext),name);
            }
            mX5WebView.reload();
        }
    }
}
