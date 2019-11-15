package com.example.x5_plugin_example;

import android.app.Application;
import android.util.Log;

import io.flutter.app.FlutterApplication;

public class MyApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();

        Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
            public void uncaughtException(Thread thread, Throwable ex) {
                Log.e("uncaughtException", ex.getMessage());
            }
        });
    }
}
