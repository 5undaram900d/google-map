
//13

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);

  final Set<Marker> _markers = {};
  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(26.403506, 80.308665),           //should be same last
    
    LatLng(26.449923, 80.331871),
    LatLng(26.490285, 80.288441),
    LatLng(26.412078, 80.098616),
    
    LatLng(26.403506, 80.308665),           //should be same first
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.2),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polygon'), centerTitle: true,),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition: _kGooglePlex,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
