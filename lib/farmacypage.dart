import 'main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FarmacyPage extends StatelessWidget {
  const FarmacyPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.all(20.0),
      child: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 14.0,
        ),
      ),
    )));
  }
}
