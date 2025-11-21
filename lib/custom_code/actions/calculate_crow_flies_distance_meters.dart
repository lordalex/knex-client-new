// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crow Flies Distance',
      home: DistanceScreen(),
    );
  }
}

class DistanceScreen extends StatefulWidget {
  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  String _distanceResult = '';
  final originController = TextEditingController(text: '34.0522,-118.2437');
  final destinationController = TextEditingController(text: '40.7128,-74.0060');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Crow Flies Distance')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Origin"),
              TextField(
                controller: originController,
                decoration: InputDecoration(
                    hintText: "Latitude, Longitude e.g. 34.0522,-118.2437"),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Destination"),
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                    hintText: "Latitude, Longitude e.g. 40.7128,-74.0060"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateDistance,
                child: Text('Calculate Distance'),
              ),
              SizedBox(height: 20),
              if (_distanceResult.isNotEmpty)
                Text(
                  'Distance: $_distanceResult m',
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ));
  }

  Future<void> _calculateDistance() async {
    final origin = _getCoordinates(originController.text);
    final destination = _getCoordinates(destinationController.text);

    double distance = calculateCrowFliesDistanceMeters(origin['lat']!,
        origin['lng']!, destination['lat']!, destination['lng']!);
    setState(() {
      _distanceResult = distance.toStringAsFixed(2);
    });
  }

  Map<String, double> _getCoordinates(String coordinates) {
    final split = coordinates.split(',');
    return {'lat': double.parse(split[0]), 'lng': double.parse(split[1])};
  }
}

double calculateCrowFliesDistanceMeters(
    double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // Radius of the earth in meters

  // Convert latitude and longitude from degrees to radians
  double lat1Rad = _toRadians(lat1);
  double lon1Rad = _toRadians(lon1);
  double lat2Rad = _toRadians(lat2);
  double lon2Rad = _toRadians(lon2);

  // Haversine formula
  double dlon = lon2Rad - lon1Rad;
  double dlat = lat2Rad - lat1Rad;

  double a = pow(sin(dlat / 2), 2) +
      cos(lat1Rad) * cos(lat2Rad) * pow(sin(dlon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c; // Distance in meters
  return distance;
}

// Helper function to convert degrees to radians
double _toRadians(double degrees) {
  return degrees * pi / 180;
}
