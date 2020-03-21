import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'locationStepper.dart';


class LocationService {

  Future<String> _loadLocationsAsset() async {
    return await rootBundle.loadString('assets/locations.json');
  }

  Future<LocationList> loadLocations() async {
    String jsonString = await _loadLocationsAsset();
    final jsonResponse = json.decode(jsonString);
    LocationList locations = new LocationList.fromJson(jsonResponse);
    return locations;
  }

}


class Location {

  String locationName;
  String locationAddress;
  String photo;
  String directions;
  double longitude;
  double latitude;
  String story;
  String question;
  String answer;
  String usualAnswer;
  List<LocationStep> locationSteps;

  Location({this.locationName,
    this.locationAddress,
    this.photo,
    this.directions,
    this.longitude,
    this.latitude,
    this.story,
    this.question,
    this.answer,
    this.usualAnswer,
    this.locationSteps});



  factory Location.fromJson(Map<String, dynamic> json){

    var list = json['locationSteps'] as List;
    print(list.runtimeType);
    List<LocationStep> stepsList = list.map((i) => LocationStep.fromJson(i)).toList();

    return Location(
        locationName: json['locationName'],
        locationAddress: json['locationAddress'],
        photo: json['photo'],
        directions: json['directions'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        story: json['story'],
        question: json['question'],
        answer: json['answer'],
        usualAnswer: json['usualAnswer'],
        locationSteps: stepsList
    );
  }
}


class LocationStep {
  String title;
  String content;

  LocationStep({this.title, this.content});

  factory LocationStep.fromJson(Map<String, dynamic> json){

    return LocationStep(
        title: json['title'],
        content: json['content'],
    );
  }
}

class LocationList {
  List<Location> locations = new List();

  LocationList({
    this.locations
  });

  factory LocationList.fromJson(List parsedJson) {

    List<Location> locations = new List<Location>();

    locations = parsedJson.map((i) => Location.fromJson(i)).toList();

    return new LocationList(
      locations: locations,
    );
  }
}


class locationDetail extends StatelessWidget {

  Location location;
  locationDetail({Key key, @required this.location}): super(key: key);


  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

  }

  @override
  Widget build(BuildContext context) {


    LatLng _center = LatLng(location.longitude, location.latitude);

    // View creation will be here.
    return DefaultTabController(
      // initialIndex: 1,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(location.locationName),
            bottom: TabBar(
              tabs: <Widget>[
                Text('Description'),
                Text('Directions', ),
                Text('Quiz', ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Row(
                     children : <Widget>[
                       Expanded( flex: 1,
                     child: Image.asset(
                    location.photo,
                      fit: BoxFit.fitWidth,
                    ),
                    ),
                     ],
                   ),
                   Container(
                     padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
                     child: new Text(location.story,
                       textAlign: TextAlign.left,
                       style: new TextStyle(
                           fontSize: 16,
                       ),
                      ),
                   ),
                 ],
              ),
              GoogleMap(
                onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),

              LocationStepper(title: "Test", location: location),
            ],
          )
      ),
    );
  }
}


