import 'package:flutter/material.dart';

import 'package:platform_view/platform_view.dart';
import 'package:platform_view_example/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final List<List<double>> polygon = LatLongData.polygon;
  final List<double> centroid = LatLongData.centroid;

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, double>>> object =
        createHeatmapMultipleLayers([-53.9357703024176, -15.0178982321176]);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: PlatformView(
          zoom: 13,
          polygon: polygon,
          heatmap: object,
          centroid: centroid,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlEnabled: false,
        ),
        // Center(
        //   child: Text('Running on: $_platformVersion\n'),
        // ),
      ),
    );
  }
}

List<Map<String, double>> createHeatmapObject(List<double> latLng) {
  double startingLat = latLng[1];
  double startingLng = latLng[0];
  List<Map<String, double>> object = [];
  for (var i = 0; i < 100; i++) {
    for (var y = 0; y < 100; y++) {
      object.add({"lat": startingLat, "lng": startingLng, "intensity": 1});
      startingLat += 0.0005;
    }
    startingLng += 0.0005;
    startingLat = latLng[1];
  }

  return object;
}

List<List<Map<String, double>>> createHeatmapMultipleLayers(
    List<double> latLng) {
  List<Map<String, double>> rawList = createHeatmapObject(latLng);
  List<List<Map<String, double>>> multipleLayers = [];
  List<Map<String, double>> transitoryList = [];
  for (var i = 0; i < rawList.length; i++) {
    transitoryList.add(rawList[i]);
    if (transitoryList.length == 1000) {
      multipleLayers.add(transitoryList);
      transitoryList = [];
    }
  }
  return multipleLayers;
}
