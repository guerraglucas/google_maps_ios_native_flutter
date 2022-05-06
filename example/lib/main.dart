import 'package:flutter/material.dart';

import 'package:platform_view/platform_view.dart';

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

  final List<List<double>> polygon = [
    [-37.1886, 145.708],
    [-37.8361, 144.845],
    [-38.4034, 144.192],
    [-38.7597, 143.67],
    [-36.9672, 141.083],
    [-37.1886, 145.708],
  ];

  List<Map<String, double>> object = createHeatmapObject();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: PlatformView(
          polygon: polygon,
          heatmap: object,
        ),
        // Center(
        //   child: Text('Running on: $_platformVersion\n'),
        // ),
      ),
    );
  }
}

List<Map<String, double>> createHeatmapObject() {
  List<Map<String, double>> object = [];
  for (var i = 0; i <= 1000; i++) {
    var doubleI = i.toDouble();
    object.add(
        {"lat": -37.7708 + doubleI / 1000, "lng": 144.957 + doubleI / 1000});
  }
  for (var i = 0; i <= 1000; i++) {
    var doubleI = i.toDouble();

    object.add(
        {"lat": -37.7708 - doubleI / 1000, "lng": 144.957 - doubleI / 1000});
  }
  for (var i = 0; i <= 1000; i++) {
    var doubleI = i.toDouble();

    object.add(
        {"lat": -37.7708 + doubleI / 1000, "lng": 144.957 - doubleI / 1000});
  }
  for (var i = 0; i <= 1000; i++) {
    var doubleI = i.toDouble();

    object.add(
        {"lat": -37.7708 - doubleI / 1000, "lng": 144.957 + doubleI / 1000});
  }

  return object;
}
