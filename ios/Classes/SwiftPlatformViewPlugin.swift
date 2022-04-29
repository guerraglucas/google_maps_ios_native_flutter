import Flutter
import UIKit

public class SwiftPlatformViewPlugin: NSObject, FlutterPlugin {


    public static func register(with registrar: FlutterPluginRegistrar) {
      // let instance = SwiftPlatformViewPlugin()
      // let defaultChannel = FlutterMethodChannel(name: "platform_view", binaryMessenger: registrar.messenger())
      // registrar.addMethodCallDelegate(instance, channel: defaultChannel)
      registrar.register(PlatformViewPluginViewFactory(messenger: registrar.messenger()), withId: "<platform-view-type>")
  }
}