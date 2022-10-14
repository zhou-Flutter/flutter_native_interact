import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let batteryChannel = FlutterMethodChannel(name: "flutter_native_interact",
                                                binaryMessenger: controller.binaryMessenger)
      
      
      batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        // This method is invoked on the UI thread.
          
          switch call.method
          {
              case "interact":
                  self?.getMessage(call: call,result: result)
              case "eventInteract":
                  result("success")
                  EventChannel(messenger: controller.binaryMessenger)
              default:
              result(FlutterMethodNotImplemented)
              return
          }
          
      })
      
      
    GeneratedPluginRegistrant.register(with: self)

    let registrar:FlutterPluginRegistrar = self.registrar(forPlugin: "custom_platform_view_ios")!
    let factory = FLNativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "custom_platform_view_ios")
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
    
    private func getMessage(call: FlutterMethodCall,result: FlutterResult) {
        let date = call.arguments as! [String:String]
        result("IOS收到消息：\(date["info"]!)")
    }
}
