import Flutter
import UIKit
import GoogleMaps
import GoogleMapsUtils

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

    func getOtSetupMapsView() -> GMSMapView {
        if let mapView = mapView {
            return mapView
        }
        let camera = GMSCameraPosition.camera(withLatitude: -37.1886, longitude: 145.708, zoom: 10)
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.mapView = mapView
        mapView.mapType = .satellite
        let polygon = createPolygons()
        polygon.map = mapView
        let heatmap = addHeatmap()
        heatmap.map = mapView

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

        //create the polygon, and assign it to the map

        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        polygon.strokeColor = .black
        polygon.strokeWidth = 2
        return polygon
    }

    func addHeatmap() -> GMUHeatmapTileLayer {

    var heatmapLayer = GMUHeatmapTileLayer()

    let object: [[String : Double]] = [
        ["lat" : -37.1886, "lng" : 145.708 ] ,
        ["lat" : -37.8361, "lng" : 144.845 ],
        ["lat" : -38.4034, "lng" : 144.192 ],
        ["lat" : -38.7597, "lng" : 143.67 ] ,
        ["lat" : -36.9672, "lng" : 141.083 ]
    ]

    var list = [GMUWeightedLatLng]()
    for item in object {
      let lat = item["lat"] as! CLLocationDegrees
      let lng = item["lng"] as! CLLocationDegrees
      let coords = GMUWeightedLatLng(
        coordinate: CLLocationCoordinate2DMake(lat, lng),
        intensity: 1.0
      )
      list.append(coords)
    }

    // Add the latlngs to the heatmap layer.
    heatmapLayer.weightedData = list

    return heatmapLayer
}
}