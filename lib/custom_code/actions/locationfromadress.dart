// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> locationfromadress(String address) async {
  final Map<String, String> headers = {
    'User-Agent': 'knexClient/1.0 (support@lordalexand.co)',
  };

  final encodedAddress = Uri.encodeComponent(address);
  // Using Nominatim Search API
  // format=jsonv2 provides a more structured json
  // addressdetails=1 includes detailed address components
  // limit=1 returns only the most relevant result
  final url =
      'https://nominatim.openstreetmap.org/search?q=$encodedAddress&format=jsonv2&addressdetails=1&limit=1';

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // Nominatim returns a JSON *array* of results
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        // Take the first result
        final result = data[0];
        final addressDetails =
            result['address'] as Map<String, dynamic>?; // Address components

        // Extract coordinates (Nominatim often returns them as strings)
        final latitude = double.tryParse(result['lat']?.toString() ?? '');
        final longitude = double.tryParse(result['lon']?.toString() ?? '');

        // Extract address components safely
        final String city = addressDetails?['city'] ??
            addressDetails?['town'] ??
            addressDetails?['village'] ??
            '';
        final String state = addressDetails?['state'] ?? '';
        final String region = addressDetails?['county'] ??
            ''; // Often 'county' in Nominatim maps to 'region'
        final String country = addressDetails?['country'] ?? '';
        final String formattedAddress = result['display_name'] ?? '';

        if (latitude != null && longitude != null) {
          return jsonEncode({
            'status': 'success',
            'latitude': latitude,
            'longitude': longitude,
            'formatted_address': formattedAddress,
            'city': city,
            'state': state,
            'region': region, // Mapped from county
            'country': country,
          });
        } else {
          return jsonEncode({
            'status': 'error',
            'message': 'Failed to parse coordinates from Nominatim response.',
          });
        }
      } else {
        // Address not found by Nominatim
        return jsonEncode({
          'status': 'error',
          'message': 'Address not found.',
        });
      }
    } else {
      // Handle non-200 HTTP status codes
      return jsonEncode({
        'status': 'error',
        'message':
            'Failed to connect to Nominatim service. Status code: ${response.statusCode}',
        'body': response.body, // Include body for debugging if needed
      });
    }
  } catch (e) {
    // Handle network errors or JSON parsing errors
    return jsonEncode({
      'status': 'error',
      'message': 'An error occurred: ${e.toString()}',
    });
  }
}
