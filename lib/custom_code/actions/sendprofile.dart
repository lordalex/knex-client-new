// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

// Logging levels with color coding
enum LogLevel {
  INFO,
  WARNING,
  ERROR,
  DEBUG,
}

// Set the verbosity level (0-3, where 3 is most verbose)
const int verbosity = 3;

// Enhanced logging function
void log(LogLevel level, String message) {
  if (level.index <= verbosity) {
    final timestamp = DateTime.now().toIso8601String();
    final prefix = level.toString().split('.').last;
    final color = {
      LogLevel.INFO: '\x1B[32m', // Green
      LogLevel.WARNING: '\x1B[33m', // Yellow
      LogLevel.ERROR: '\x1B[31m', // Red
      LogLevel.DEBUG: '\x1B[34m', // Blue
    }[level];
    final resetColor = '\x1B[0m';
    print('$color[$timestamp][$prefix] $message$resetColor');
  }
}

Future<String> sendprofile(
    String baseUrl,
    String firstName,
    String lastName,
    String phone,
    String email,
    String token,
    String city,
    String photo,
    String state,
    String address) async {
  log(LogLevel.INFO, 'Starting sendprofile function...');

  // 1. Pre-computation and Validation
  final params = {
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'photo': photo,
    'token': token,
    'address': address,
    'baseUrl': baseUrl,
  };

  for (var entry in params.entries) {
    if (entry.value.isEmpty) {
      log(LogLevel.ERROR, '${entry.key} cannot be empty.');
      throw Exception('${entry.key} cannot be empty.');
    }
  }

  final profile = {
    "firstname": firstName,
    "lastname": lastName,
    "email": email,
    "phone": phone,
    "photo": photo,
    "address": address,
    "state": state,
    "city": city
  };

  Uri uri;
  try {
    uri = Uri.parse(baseUrl);
    log(LogLevel.DEBUG, 'URI parsed successfully: $uri');
  } catch (e) {
    log(LogLevel.ERROR, 'Error parsing URI: $e');
    throw Exception('URI parsing failed: $e');
  }

  final requestBody =
      jsonEncode({"idToken": token, "data": {"insData": jsonEncode(profile)}});
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};

  // 2. Pre-API Call Logging
  log(LogLevel.INFO, 'Preparing to send HTTP POST request to $uri');
  log(LogLevel.DEBUG, 'Request Headers: ${jsonEncode(headers)}');
  log(LogLevel.DEBUG, 'Request Body: $requestBody');

  // 3. API Call
  http.Response response;
  try {
    response = await http
        .post(
      uri,
      headers: headers,
      body: requestBody,
    )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        log(LogLevel.ERROR, 'Request to $uri timed out after 30 seconds.');
        throw Exception('Request timed out');
      },
    );
  } catch (e) {
    log(LogLevel.ERROR, 'HTTP request to $uri failed: $e');
    throw Exception('HTTP request failed: $e');
  }

  // 4. Post-API Call Logging
  log(LogLevel.INFO,
      'Received response from $uri with status code: ${response.statusCode}');
  log(LogLevel.DEBUG, 'Response Body: ${response.body}');

  // 5. Post-computation and Response Handling
  if (response.statusCode >= 200 && response.statusCode < 300) {
    try {
      final responseData = json.decode(response.body);
      log(LogLevel.INFO, 'Successfully parsed response data.');
      log(LogLevel.DEBUG, 'Parsed Response Data: $responseData');
      return jsonEncode(responseData);
    } catch (e) {
      log(LogLevel.WARNING, 'Could not parse response body: $e');
      return response.body;
    }
  } else {
    String errorMessage =
        'Request failed with status: ${response.statusCode}';
    switch (response.statusCode) {
      case 400:
        errorMessage = 'Bad request: Invalid data format';
        break;
      case 401:
        errorMessage = 'Unauthorized: Invalid token';
        break;
      case 403:
        errorMessage = 'Forbidden: Insufficient permissions';
        break;
      case 404:
        errorMessage = 'API endpoint not found';
        break;
      case 500:
        errorMessage = 'Server error occurred';
        break;
    }
    log(LogLevel.ERROR, 'API Error: $errorMessage. Response: ${response.body}');
    throw Exception(errorMessage);
  }
}
