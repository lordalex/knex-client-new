// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:location/location.dart';

Future<String> location() async {
  Location location = Location();

  try {
    // Check if location services are enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return ''; // Return empty string if services are not enabled
      }
    }

    // Check for location permissions
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return ''; // Return empty string if permissions are not granted
      }
    }

    // Fetch the current location
    LocationData locationData = await location.getLocation();

    // Log the location data for debugging
    print('Location Data: $locationData');

    // Return the latitude and longitude as a JSON-encoded string
    return jsonEncode({
      'lat': locationData.latitude,
      'lon': locationData.longitude,
    });
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error fetching location: $e');
    return ''; // Return empty string in case of an error
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
