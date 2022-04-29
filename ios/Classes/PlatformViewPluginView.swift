import Flutter
import UIKit
import GoogleMaps

class PlatformViewPluginView: NSObject, FlutterPlatformView {
    // private var _view: UIView
    private let channel: FlutterMethodChannel
    private let messenger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: Any
    private var mapView: GMSMapView?

    init(frame: CGRect,
    viewId: Int64,
    args: Any?,
    messenger: FlutterBinaryMessenger
    ) {
        self.args = args
        self.messenger = messenger
        self.frame = frame
        self.viewId = viewId
        channel = FlutterMethodChannel(name: "platform-view", binaryMessenger: messenger)
        // _view = UIView()
        super.init()
        //iOS views can be created here
        // createNativeView(view: _view)
    }

    func view() -> UIView {
        // return _view
        return getOtSetupMapsView()
    }

    func createNativeView(view _view: UIView) {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.map(withFrame: _view.frame, camera: camera)
        mapView.mapType = .satellite
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48)
        _view.addSubview(mapView)
    }

    func getOtSetupMapsView() -> GMSMapView {
        if let mapView = mapView {
            return mapView
        }
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.mapView = mapView
        mapView.mapType = .satellite
        // mapView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
        // self.mapView.delegate = self
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        return mapView
    }
}