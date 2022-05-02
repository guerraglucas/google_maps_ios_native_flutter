import Flutter
import UIKit
import GoogleMaps

class PlatformViewPluginView: NSObject, FlutterPlatformView {
    // private var _view: UIView
    private let channel: FlutterMethodChannel
    private let messenger: FlutterBinaryMessenger
    private let frame: CGRect
    private let viewId: Int64
    private let args: [String: Any]
    private var mapView: GMSMapView?

    init(frame: CGRect,
    viewId: Int64,
    args: [String : Any],
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
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 12)
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
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.2, zoom: 29)
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.mapView = mapView
        mapView.mapType = .satellite
        let polygon = createPolygons()
        polygon.map = mapView

        // mapView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
        // self.mapView.delegate = self
        // let marker = GMSMarker()
        // marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        // marker.title = "Sydney"
        // marker.snippet = "Australia"
        // marker.map = mapView
        return mapView
    }

    func createPolygons() -> GMSPolygon {

        // create a retangular path
        let rect = GMSMutablePath()

        let listLatLong = args["latLong"] as! Array<Array<Double>>
        for latLong in listLatLong {
            rect.add(CLLocationCoordinate2D(latitude: latLong[0], longitude: latLong[1]))
        }
        // rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        // rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        // rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        // rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))

        //create the polygon, and assign it to the map

        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        polygon.strokeColor = .black
        polygon.strokeWidth = 2
        return polygon
    }
}