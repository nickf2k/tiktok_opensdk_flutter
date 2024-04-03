import Flutter
import UIKit
import TikTokOpenSDKCore


public class TiktokOpenSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tiktok_open_sdk", binaryMessenger: registrar.messenger())
    let instance = TiktokOpenSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
      case "shareToTiktok":
      result("SUCCESS")
      case "loginToTiktok":
      result("SUCCESS")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
