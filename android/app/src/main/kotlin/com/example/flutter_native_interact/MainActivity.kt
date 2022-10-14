package com.example.flutter_native_interact

import android.os.Bundle
import android.os.Handler
import android.os.Looper


import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.EventChannel
import java.util.*


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 本地注册
        FlutterNativeInteract.registerWith(this,this.flutterEngine)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //注册视图
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("custom_platform_view_android", NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))
    }


}
