
//15) Polyline=> line which is draw b/w one place to another place

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(26.403506, 80.308665),       //1st place
    LatLng(26.449923, 80.331871),
    LatLng(26.490285, 80.288441),
    LatLng(26.412078, 80.098616),       //last place
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0; i<latlng.length; i++){
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(title: 'Nice Place', snippet: '4 Star Rating'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {

      });
      _polyline.add(
        Polyline(
          polylineId: PolylineId('1'),
          points: latlng,
          color: Colors.red.withOpacity(0.4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polyline'), centerTitle: true,),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        myLocationEnabled: true,
        mapType: MapType.normal,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
