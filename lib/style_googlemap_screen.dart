
//16
/*
Set api by the help of
https://mapstyle.withgoogle.com/
Select any theme then copy Json & make a assets folder and copy it
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {

  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(26.403506, 80.308665), zoom: 14.4746);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/mapThemes/aubergine_theme.json').then((value){mapTheme=value;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMap Theme'),
        actions: [
          PopupMenuButton(itemBuilder: (context)=> [
            PopupMenuItem(
              onTap: (){
                _controller.future.then((value){
                  DefaultAssetBundle.of(context).loadString('assets/mapThemes/aubergine_theme.json').then((string) => value.setMapStyle(string));
                });
              },
              child: Text('Aubergine'),
            ),
            PopupMenuItem(
              onTap: (){
                _controller.future.then((value){
                  DefaultAssetBundle.of(context).loadString('assets/mapThemes/dark_theme.json').then((string) => value.setMapStyle(string));
                });
              },
              child: Text('Dark'),
            ),
            PopupMenuItem(
              onTap: (){
                _controller.future.then((value){
                  DefaultAssetBundle.of(context).loadString('assets/mapThemes/night_theme.json').then((string) => value.setMapStyle(string));
                });
              },
              child: Text('Night'),
            ),
            PopupMenuItem(
              onTap: (){
                _controller.future.then((value){
                  DefaultAssetBundle.of(context).loadString('assets/mapThemes/retro_theme.json').then((string) => value.setMapStyle(string));
                });
              },
              child: Text('Retro'),
            ),
            PopupMenuItem(
              onTap: (){
                _controller.future.then((value){
                  DefaultAssetBundle.of(context).loadString('assets/mapThemes/silver_theme.json').then((string) => value.setMapStyle(string));
                });
              },
              child: Text('Silver'),
            ),
          ]),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        // mapType: MapType.normal,          //can't use for multiple theme
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
