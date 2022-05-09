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
        let centroid = args["centroid"] as! Array<Double>
        let camLat = centroid[0] as! Double
        let camLng = centroid[1] as! Double
        let zoom = args["zoom"] as! Float
        if let mapView = mapView {
            return mapView
        }
        let camera = GMSCameraPosition.camera(withLatitude: camLng, longitude: camLat, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.mapView = mapView
        mapView.mapType = .satellite
        let polygon = createPolygons()
        polygon.map = mapView

        if args.keys.contains { $0 == "heatmap"} {

            let heatmap = addHeatmap()
            heatmap.map = mapView
        }


        return mapView
    }

    func createPolygons() -> GMSPolygon {

        // create a retangular path
        let rect = GMSMutablePath()

        let listLatLong = args["polygon"] as! Array<Array<Double>>
        for latLong in listLatLong {
            rect.add(CLLocationCoordinate2D(latitude: latLong[1], longitude: latLong[0]))
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

    var object: [[String : Any]] =  args["heatmap"] as! [[String: Any]]

    heatmapLayer.radius = 200

    var list = [GMUWeightedLatLng]()
    for item in object {
      let lat = item["lat"] as! CLLocationDegrees
      let lng = item["lng"] as! CLLocationDegrees
      let intensity = item["intensity"] as! Float
      let coords = GMUWeightedLatLng(
        coordinate: CLLocationCoordinate2DMake(lat, lng),
        intensity: intensity
      )
      list.append(coords)
    }
    let gradientColors: [UIColor] = [.green, .red]
    let gradientStartPoints: [NSNumber] = [0.1, 1.0]
    heatmapLayer.gradient = GMUGradient(
        colors: gradientColors,
        startPoints: gradientStartPoints,
        colorMapSize: 12
    )

    // Add the latlngs to the heatmap layer.
    heatmapLayer.weightedData = list
    heatmapLayer.opacity = 0.8

    return heatmapLayer
}


}