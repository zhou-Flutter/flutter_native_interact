package com.example.flutter_native_interact

import android.app.Activity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class FlutterNativeInteract : FlutterPlugin, MethodChannel.MethodCallHandler {

    lateinit var channel: MethodChannel



    companion object {
        lateinit var flutterEngine :FlutterEngine
        const val CHANNEL = "flutter_native_interact"
        lateinit  var activity: Activity

        fun registerWith(activity: Activity, flutterEngine: FlutterEngine?) {
            flutterEngine?.plugins?.add(FlutterNativeInteract())
            if (flutterEngine != null) {
                this.flutterEngine = flutterEngine
                this.activity  = activity
            }
        }
    }


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "interact" -> {
                result.success(getMessage(call))
            }
            "eventInteract" -> {
                result.success("success")
                EventChannel(activity, flutterEngine)
            }
            else -> {
                result.notImplemented()
            }
        }

    }



    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    //处理消息
    fun getMessage(call: MethodCall): String {
        var date =  call.argument<String>("info");

        return "Android收到信息: $date";
    }

}
