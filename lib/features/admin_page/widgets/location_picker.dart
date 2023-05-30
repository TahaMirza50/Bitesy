import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'form_field.dart';

class LocationPicker extends StatefulWidget {
  LocationPicker({super.key, required this.latLng});

  LatLng latLng;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.black,
      child: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(10, 10),zoom: 10),),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Save Location"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                ),
              ))
        ],
      ),
    );
  }
}
