
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);
  
  final List<Marker> _markers = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(26.403506, 80.308665),
      infoWindow: InfoWindow(title: "My Position"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(26.449923, 80.331871),
      infoWindow: InfoWindow(title: "My Shop"),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(25.312002, 80.538009),
      infoWindow: InfoWindow(title: "Current Location"),
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _markers.addAll(_list);      //use addAll because it is a list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.hybrid,        //many types available
          compassEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(target: LatLng(25.312002, 80.538009), zoom: 14,),),);
          setState(() {

          });
        },
        child: const Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
