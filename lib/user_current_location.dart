
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() => _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState extends State<GetUserCurrentLocationScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(26.403506, 80.308665),
      infoWindow: InfoWindow(title: "My Position"),
    ),
  ];


  //for current location
  loadData(){
    getUserCurrentLocation().then((value)async{
      print("My Current Location: ${value.latitude} ${value.longitude}");
      _markers.add(
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'My Current Location'),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 14,);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

      }
    ).onError((error, stackTrace) {
      print("Error: $error");
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),floatingActionButton: FloatingActionButton(
      onPressed: (){

      },
      child: Icon(Icons.local_activity),
    ),
    );
  }
}
