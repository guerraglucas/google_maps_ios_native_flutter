import 'dart:math';

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
    List<Map<String, double>> object = createHeatmapObject(polygon, centroid);
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

List<Map<String, double>> createHeatmapObject(
    List<List<double>> polygon, List<double> centroid) {
  var random = Random();
  List<Map<String, double>> object = [];
  for (var i = 0; i < polygon.length; i++) {
    // var randomIntensity = random.nextInt(10).toDouble();
    object.add({"lat": polygon[i][1], "lng": polygon[i][0], "intensity": 1});
  }
  object.add({"lat": centroid[1], "lng": centroid[0], "intensity": 1});

  print(object);
  return object;
}
