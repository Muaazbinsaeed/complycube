import ComplyCubeMobileSDK
import Flutter
import UIKit

public class ComplycubePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "complycube_methods", binaryMessenger: registrar.messenger())
    let errorChannel = FlutterEventChannel(name: "complycube_error", binaryMessenger: registrar.messenger())
    let errorsChannel = FlutterEventChannel(name: "complycube_errors", binaryMessenger: registrar.messenger())
    let resultChannel = FlutterEventChannel(name: "complycube_result", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "complycube_events", binaryMessenger: registrar.messenger())
    
    let instance = ComplycubePlugin()
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    errorChannel.setStreamHandler((CCubeEventErrorDelegate() as! FlutterStreamHandler & NSObjectProtocol))
    errorsChannel.setStreamHandler((CCubeEventErrorsDelegate() as! FlutterStreamHandler & NSObjectProtocol))
    resultChannel.setStreamHandler((CCubeEventResultDelegate() as! FlutterStreamHandler & NSObjectProtocol))
    eventChannel.setStreamHandler((CCubeEventDelegate() as! FlutterStreamHandler & NSObjectProtocol))
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "openCCubeNativeBuild":
      let args = call.arguments as? [String: AnyObject]
      if let rootViewController = UIApplication.shared.keyWindow?.rootViewController?.getAppViewController() {
        // Create an instance of your view controller
        let yourViewController = CCubeViewController()
        yourViewController.openComplyCubeNativeFormBuilder(args: args)

        // Present the view controller
        if (rootViewController is UINavigationController) {
            (rootViewController as! UINavigationController).pushViewController(yourViewController, animated:true)
            result("ViewController presented successfully::a")
        } else {
            let navigationController: UINavigationController! = UINavigationController(rootViewController: yourViewController)
            rootViewController.present(navigationController, animated: true, completion: nil)
            result("ViewController presented successfully::b")
        }
      } else {
          result(FlutterError(code: "c0", message: "Error: Could not present ViewController", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}


