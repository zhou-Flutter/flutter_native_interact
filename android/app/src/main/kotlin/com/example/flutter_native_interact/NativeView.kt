package com.example.flutter_native_interact

import android.content.Context
import android.graphics.Color
import android.os.Build
import android.view.View
import android.widget.TextView
import androidx.annotation.RequiresApi
import com.example.flutter_native_interact.FlutterNativeInteract.Companion.flutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


class NativeView(context: Context, messenger: BinaryMessenger, id: Int, creationParams: Map<String?, Any?>?) : PlatformView, MethodChannel.MethodCallHandler {
    private val textView: TextView
    private var methodChannel: MethodChannel

    init {
        methodChannel = MethodChannel(messenger, "flutter_native_page")
        methodChannel.setMethodCallHandler(this)


        textView = TextView(context)
        textView.textSize = 33f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "我是Android 原生视图";
        textView.text = creationParams?.get("text").toString()


    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "sendNativePage") {
            val text = call.argument("info") as String?
            textView.text = "android 原生收到消息:,$text"
        } else {
            result.notImplemented()
        }
    }


}


