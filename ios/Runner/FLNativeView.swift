import Flutter
import UIKit


class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var text:String = "Native text from iOS"
    var textView = UILabel()

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        
        //初始化 接受flutter 的参数
        if(args is NSDictionary){
            let dict = args as! NSDictionary
            text = dict.value(forKey: "text") as! String
        }
        
        createChannel(binaryMessenger:messenger)
        
        createView()
        
    }

    func view() -> UIView {
        return textView
    }
    
    func createView(){
        textView.text = text
        textView.textColor = UIColor.red
    }
    
    func  createChannel(binaryMessenger  messenger: FlutterBinaryMessenger ){
        //创建通道
        let channel = FlutterMethodChannel(name: "flutter_native_page",binaryMessenger: messenger)
        channel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) ->Void  in
          // This method is invoked on the UI thread.
            switch call.method
            {
            case "sendNativePage":
                let date = call.arguments as! [String:String]
                self.textView.text = "iOS原生收到消息：\(date["info"]!)"
                result("iOS原生收到消息：\(date["info"]!)")
            default:
                result(FlutterMethodNotImplemented)
            }
            
        })
    }
}
