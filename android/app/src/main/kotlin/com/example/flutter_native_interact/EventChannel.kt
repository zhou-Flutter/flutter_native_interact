package com.example.flutter_native_interact

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.EventChannel
import java.util.*



class EventChannel(var activity: Activity, flutterEngine: FlutterEngine?):EventChannel.StreamHandler {
    private var channel: EventChannel
    private var events: EventChannel.EventSink? = null
    var index = 0
    var time:Timer = Timer()

    //TODO 后续添加单列
    init {
        channel = EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, "flutter_native_eventChannel")
        channel.setStreamHandler(this)
        startTimer()
    }


    fun startTimer() {
        time.schedule(object:TimerTask(){
            override fun run() {
                index++
                activity.runOnUiThread {
                    events?.success("$index")
                    if(index==10){
                        time.cancel()
                        events?.endOfStream()
                    }
                }
            }
        }, 0, 1000)
    }


    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        this.events = null
        Log.w("Android", "EventChannel onCancel called")

    }
}




//class EventChannel{
//    private lateinit var channel: EventChannel
//    var eventSink: EventChannel.EventSink? = null
//
//   fun stateSteam(@NonNull flutterEngine: FlutterEngine,activity: Activity){
//       GeneratedPluginRegistrant.registerWith(flutterEngine)
//
//       channel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_native_eventChannel")
//       channel.setStreamHandler(
//               object : EventChannel.StreamHandler {
//                   override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
//                       eventSink = events
//                       Log.d("Android", "EventChannel onListen called")
//                       for (i in  0..100) {
//                           eventSink?.success("$i")
//                       }
//                   }
//                   override fun onCancel(arguments: Any?) {
//                       Log.w("Android", "EventChannel onCancel called")
//                   }
//               })
//    }
//
//}