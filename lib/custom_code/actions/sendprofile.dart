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
  print('Starting sendprofile function...');
  print('Starting sendprofile function...');
  print('Starting sendprofile function...');
  print('${baseUrl}, ${firstName}, ${lastName}, ${phone}, ${email}, ${token} ');
  // Initial parameter validation
  try {
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (firstName.isEmpty) {
      throw Exception('firstName cannot be empty');
    }
    if (lastName.isEmpty) {
      throw Exception('lastName cannot be empty');
    }
    if (phone.isEmpty) {
      throw Exception('phone cannot be empty');
    }
    if (photo.isEmpty) {
      throw Exception('phone cannot be empty');
    }
    if (token.isEmpty) {
      throw Exception('Token cannot be empty');
    }
    if (address.isEmpty) {
      throw Exception('Address cannot be empty');
    }
    print('Initial parameters validated');
  } catch (e) {
    print('Error in parameter validation: ${e.toString()}');
    throw Exception('Parameter validation failed: ${e.toString()}');
  }

  // Profile handling block
  String validatedProfile;
  Map<String, dynamic> defaultProfile = {};
  try {
    defaultProfile = {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "phone": phone,
      "photo": photo,
      "address": address,
      "state": state,
      "city": city
    };
    validatedProfile = jsonEncode(defaultProfile);
    print('Existing profile validated');
  } catch (e) {
    print('Error in profile handling: ${e.toString()}');
    throw Exception('Profile processing failed: ${e.toString()}');
  }

  // URI parsing block
  Uri uri;
  try {
    uri = Uri.parse(baseUrl);
    print('URI parsed successfully: $uri');
  } catch (e) {
    print('Error parsing URI: ${e.toString()}');
    throw Exception('URI parsing failed: ${e.toString()}');
  }

  // Request data preparation block
  String requestBody;
  try {
    Map<String, dynamic> postData = {
      "idToken": token,
      "data": {"insData": validatedProfile}
    };
    requestBody = jsonEncode(postData);
    print('Request data prepared: $requestBody');
  } catch (e) {
    print('Error preparing request data: ${e.toString()}');
    throw Exception('Request data preparation failed: ${e.toString()}');
  }

  // Headers preparation block
  Map<String, String> headers;
  try {
    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print('Headers prepared: $headers');
  } catch (e) {
    print('Error preparing headers: ${e.toString()}');
    throw Exception('Headers preparation failed: ${e.toString()}');
  }

  // HTTP request block
  http.Response response;
  try {
    print('Sending HTTP request...');
    response = await http
        .post(
      uri,
      headers: headers,
      body: requestBody,
    )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        print('Request timed out');
        throw Exception('Request timed out after 30 seconds');
      },
    );
    print('Response received with status code: ${response.statusCode}');
  } catch (e) {
    print('Error in HTTP request: ${e.toString()}');
    throw Exception('HTTP request failed: ${e.toString()}');
  }

  // Response handling block
  try {
    print('Processing response...');
    if (response.statusCode == 200) {
      try {
        // Try to parse response body
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Response parsed successfully: $responseData');
        return "Profile sent successfully: ${response.body}";
      } catch (e) {
        print('Could not parse response body: ${e.toString()}');
        return "Profile sent successfully (response parsing failed)";
      }
    } else {
      String errorMessage;
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
        default:
          errorMessage = 'Request failed with status: ${response.statusCode}';
      }
      throw Exception(errorMessage);
    }
  } catch (e) {
    print('Error processing response: ${e.toString()}');
    return response.statusCode.toString();
    throw Exception('Response processing failed: ${e.toString()}');
  }
}
