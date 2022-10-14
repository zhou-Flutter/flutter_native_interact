import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlatFromViewPage extends StatefulWidget {
  const PlatFromViewPage({super.key});

  @override
  State<PlatFromViewPage> createState() => _PlatFromViewPageState();
}

class _PlatFromViewPageState extends State<PlatFromViewPage> {
  final MethodChannel platform = const MethodChannel('flutter_native_page');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("原生视图")),
      body: Center(
        child: platformView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendNativePage();
        },
        child: Icon(Icons.send),
      ),
    );
  }

  //发送给原生页面
  sendNativePage() async {
    Map<String, String> date = {"info": "我是flutter"};
    String _date = await platform.invokeMethod('sendNativePage', date);
    print("$_date");
  }

  Widget platformView() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'custom_platform_view_android',
          creationParams: {'text': 'flutter 初始传参'},
          creationParamsCodec: StandardMessageCodec(),
        );
        break;
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'custom_platform_view_ios',
          creationParams: {'text': 'flutter 初始传参'},
          creationParamsCodec: StandardMessageCodec(),
        );
      default:
        return Container();
    }
  }
}
