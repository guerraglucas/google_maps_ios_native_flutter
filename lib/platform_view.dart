import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class PlatformView extends StatelessWidget {
  // static const MethodChannel _channel = MethodChannel('platform_view');

  const PlatformView(
      {Key? key,
      this.polygon,
      this.heatmap,
      required this.centroid,
      required this.zoom,
      this.zoomControlEnabled,
      this.myLocationEnabled,
      this.myLocationButtonEnabled})
      : super(key: key);

  ///receives a list of [lat, lng] to draw polygons on the map
  final List<List<double>>? polygon;

  ///receives a list of [lat, lng] to draw heatmap points on the map
  final List<Map<String, double>>? heatmap;

  ///receives a lat,lng for center the map camera
  final List<double> centroid;

  ///number for controlling the zoom of the map camera
  final int zoom;

  ///control if the zoom controls of the map are shown or not
  final bool? zoomControlEnabled;

  ///control if the current location button of the user is shown
  final bool? myLocationEnabled;
  final bool? myLocationButtonEnabled;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side

    final Map<String, dynamic> creationParams = <String, dynamic>{
      if (polygon != null) 'polygon': polygon,
      if (heatmap != null) 'heatmap': heatmap,
      'centroid': centroid,
      'zoom': zoom,
      if (zoomControlEnabled != null) 'zoomControlEnabled': zoomControlEnabled,
      if (myLocationEnabled != null) 'myLocationEnabled': myLocationEnabled,
      if (myLocationButtonEnabled != null)
        'myLocationButtonEnabled': myLocationEnabled,
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const SizedBox();
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        return const SizedBox();
    }
  }
}
