import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_interact/platform_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _date = "";
  var _evenDate = "";

  final MethodChannel platform = const MethodChannel('flutter_native_interact');

  final EventChannel _eventChannel =
      const EventChannel('flutter_native_eventChannel');
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //MethodChannel 互通
  interact() async {
    Map<String, String> date = {"info": "我是flutter"};
    _date = await platform.invokeMethod('interact', date);
    setState(() {});
  }

  //EventChannel 触发
  eventInteract() async {
    await platform.invokeMethod('eventInteract');
    _streamSubscription = _eventChannel.receiveBroadcastStream().listen(
      (event) {
        _evenDate = event.toString();
        print(_evenDate);
        setState(() {});
      },
      onError: (e) {
        print("onError:$e");
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原生互通"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("原生互通MethodChannel:$_date"),
              onTap: () {
                interact();
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("原生互通EventChannel:$_evenDate"),
              onTap: () {
                eventInteract();
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("嵌入原生视图"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlatFromViewPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
