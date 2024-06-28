
//15

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({super.key});

  @override
  State<NetworkImageCustomMarker> createState() => _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);

  final List<Marker> _markers = [];

  List<LatLng> _latlng = [
    LatLng(26.403506, 80.308665),       //1st place
    LatLng(26.449923, 80.331871),
    LatLng(26.490285, 80.288441),
    LatLng(26.412078, 80.098616),       //last place
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{
    for(int i=0; i<_latlng.length; i++){
      Uint8List? image = await loadNetworkImage('https://images.pexels.com/photos/20070397/pexels-photo-20070397/free-photo-of-peach02.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      final Uint8List resizeImageMarker = byteData!.buffer.asUint8List();

      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(resizeImageMarker),
          infoWindow: InfoWindow(title: 'Title of marker $i', snippet: 'Snippet $i'),
        ),
      );
      setState(() {

      });
    }
  }

  Future<Uint8List> loadNetworkImage(String path)async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _)=> completer.complete(info))
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network image Marker'), centerTitle: true,),
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
