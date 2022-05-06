import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class PlatformView extends StatelessWidget {
  // static const MethodChannel _channel = MethodChannel('platform_view');

  const PlatformView({Key? key, this.polygon, this.heatmap}) : super(key: key);

  ///receives a list of [lat, lng] to draw polygons on the map
  final List<List<double>>? polygon;

  ///receives a list of [lat, lng] to draw heatmap points on the map
  final List<Map<String, double>>? heatmap;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'polygon': polygon,
      'heatmap': heatmap
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

  //   rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
  // rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
  // rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
  // rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
}
