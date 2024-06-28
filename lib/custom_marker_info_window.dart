
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i=0; i<_latLang.length; i++){
      if(i%2==0){
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latLang[i],
              onTap: (){
                _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: CircleAvatar(radius: 30, backgroundColor: Colors.blue,),),
                  ),
                  _latLang[i],
                );
              }
          ),
        );
      }
      else{
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLang[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.pexels.com/photos/15759912/pexels-photo-15759912/free-photo-of-sunburn.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('Wonder View', maxLines: 1, overflow: TextOverflow.fade, softWrap: false,),
                            ),
                            const Spacer(),
                            Text('.3mi.'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text('This is a very beautiful Area for compain, It is very wet & clean..', maxLines: 2, overflow: TextOverflow.fade, softWrap: false,),
                            ),
                            const Spacer(),
                            Text('.3mi.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _latLang[i],
              );
            }
          ),
        );
      }
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Marker Info  Window'), backgroundColor: Colors.red,),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14,),
            markers: Set<Marker>.of(_markers),
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(controller: _customInfoWindowController, height: 200, width: 300, offset: 35,),
        ],
      ),
    );
  }
}
