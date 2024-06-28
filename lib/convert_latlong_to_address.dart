
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({super.key});

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {

  var stAddress = 'LonLat(25.479838, 80.344047)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map'), centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(stAddress, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),),
          GestureDetector(
            onTap: () async{
              // List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(25.479838, 80.344047);
              setState(() {
                // stAddress = "${locations.last.longitude} ${locations.last.longitude}";
                stAddress = "${placemarks.reversed.last.country} ${placemarks.reversed.last.locality}";
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50, 
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(child: Text('Convert LanLong to Address'),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
