
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = ['images/airport.png', 'images/auto.png', 'images/car.png', 'images/home.png', 'images/motor_cycle.png', 'images/rail.png'];

  final List<Marker> _markers = <Marker>[
    // Marker(markerId: MarkerId('12'), position: LatLng(26.403506, 80.308665),),  //for Single Marker
  ];
  final List<LatLng> _latLang = <LatLng>[
    LatLng(26.403506, 80.308665),
    LatLng(26.449923, 80.331871),
    LatLng(25.312002, 80.538009),
    LatLng(26.382310, 80.309134),
    LatLng(26.490285, 80.288441),
    LatLng(26.412078, 80.098616),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.412078, 80.098616), zoom: 14,);

  Future<Uint8List> getBytesFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width,);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{
    for(int i=0; i<images.length; i++){
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
          // icon: BitmapDescriptor.defaultMarker,       //for default marker
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: 'Position $i'),
        ),
      );
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
