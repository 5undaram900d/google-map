
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_tut/credentials.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlaceApiScreen extends StatefulWidget {
  const GoogleSearchPlaceApiScreen({super.key});

  @override
  State<GoogleSearchPlaceApiScreen> createState() => _GoogleSearchPlaceApiScreenState();
}

class _GoogleSearchPlaceApiScreenState extends State<GoogleSearchPlaceApiScreen> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  onChange(){
    if(_sessionToken==null){
      _sessionToken = uuid.v4();
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input)async{
    String baseURl = 'https://maps.googleapis.com/api/place/autocomplete/json';
    String request = '$baseURl?input=$input&key=$API_KEY_GOOGLE_MAP&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);

    if(response.statusCode==200){
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }
    else{
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Search Places Api'), centerTitle: true, elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search places by name',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: ()async{
                      List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                      print(locations.last.latitude);
                      print(locations.last.longitude);
                    },
                    title: Text(_placesList[index]['description']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
