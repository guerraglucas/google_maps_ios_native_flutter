import Flutter
import UIKit

class PlatformViewPluginViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger : FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
    ) -> FlutterPlatformView {
        return PlatformViewPluginView(
            frame: frame,
            viewId: viewId,
            args: args,
            messenger: messenger
        )
    }
}