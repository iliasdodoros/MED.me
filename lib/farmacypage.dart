import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'package:maps_launcher/maps_launcher.dart';

class FarmacyPage extends StatefulWidget {
  const FarmacyPage({super.key});

  @override
  State<FarmacyPage> createState() => _FarmacyPage();
}

class _FarmacyPage extends State<FarmacyPage> {
  LocationData? _currentLocation;
  final Location _locationService = Location();
  late PermissionStatus _permission;
  bool _loading = true;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // _checkPermission();
    // _addPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    _checkPermission();
    _addPharmacies();

    return (_loading)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng((_currentLocation?.latitude) as double,
                    (_currentLocation?.longitude) as double),
                zoom: 14.0,
              ),
              onMapCreated: (GoogleMapController controller) {},
              myLocationEnabled: true,
              markers: _markers,
            ),
          );
  }

  _checkPermission() async {
    _permission = await _locationService.hasPermission();
    if (_permission == PermissionStatus.granted) {
      _getLocation();
    } else {
      _requestPermission();
    }
  }

  _requestPermission() async {
    _permission = await _locationService.requestPermission();
    if (_permission == PermissionStatus.granted) {
      _getLocation();
    }
  }

  _getLocation() async {
    _locationService.getLocation().then((LocationData locationData) {
      setState(() {
        _currentLocation = locationData;
      });
    });
  }

  openMap(String name) async {
    MapsLauncher.launchQuery(name);
  }

  _addPharmacies() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation?.latitude},${_currentLocation?.longitude}&radius=5000&type=pharmacy&key=<API_KEY>');
    var response = await http.post(url);
    var data = json.decode(response.body);
    for (var i = 0; i < data['results'].length; i++) {
      var lat = data['results'][i]['geometry']['location']['lat'];
      var lng = data['results'][i]['geometry']['location']['lng'];
      var name = data['results'][i]['name'];
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: name, onTap: () => {openMap(name)}),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet)));
    }
    _loading = false;
  }
}
