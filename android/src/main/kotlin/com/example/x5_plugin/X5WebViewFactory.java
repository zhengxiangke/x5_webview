package com.example.x5_plugin;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class X5WebViewFactory extends PlatformViewFactory {
    private Context mContext;
    private BinaryMessenger mBinaryMessenger;

    public X5WebViewFactory(BinaryMessenger binaryMessenger, Context context) {
        super(StandardMessageCodec.INSTANCE);
        mBinaryMessenger = binaryMessenger;
        mContext = context;
    }


    @Override
    public PlatformView create(Context context, int i, Object url) {
        return new X5WebViewPlatformView(context,i, url.toString(), mBinaryMessenger);
    }
}
