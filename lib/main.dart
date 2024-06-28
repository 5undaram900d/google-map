import 'package:flutter/material.dart';
import 'package:google_map_tut/convert_latlong_to_address.dart';
import 'package:google_map_tut/custom_marker.dart';
import 'package:google_map_tut/custom_marker_info_window.dart';
import 'package:google_map_tut/google_search_place_api.dart';
import 'package:google_map_tut/home_screen.dart';
import 'package:google_map_tut/network_image_marker.dart';
import 'package:google_map_tut/polygon_screen.dart';
import 'package:google_map_tut/polyline.dart';
import 'package:google_map_tut/style_googlemap_screen.dart';
import 'package:google_map_tut/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StyleGoogleMapScreen(),
    );
  }
}

