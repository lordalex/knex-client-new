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
import '/utils/florida_messages.dart';

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

Future<String> sendjsontourl(
    String jsonString, String token, String baseUrl) async {
  log(LogLevel.INFO, 'Starting sendjsontourl function...');

  // 1. Pre-computation and Validation
  if (jsonString.isEmpty) {
    log(LogLevel.ERROR, 'JSON string is empty.');
    throw Exception('JSON string cannot be empty.');
  }
  if (token.isEmpty) {
    log(LogLevel.ERROR, 'Auth token is empty.');
    throw Exception('Auth token cannot be empty.');
  }
  if (baseUrl.isEmpty) {
    log(LogLevel.ERROR, 'Base URL is empty.');
    throw Exception('Base URL cannot be empty.');
  }

  Uri uri;
  try {
    uri = Uri.parse(baseUrl);
    log(LogLevel.DEBUG, 'URI parsed successfully: $uri');
  } catch (e) {
    log(LogLevel.ERROR, 'Error parsing URI: $e');
    throw Exception('URI parsing failed: $e');
  }

  String requestBody;
  try {
    dynamic jsonData = json.decode(jsonString);
    Map<String, dynamic> postData;
    if (baseUrl.contains('searchUser')) {
      postData = {
        "idToken": token,
        "data": jsonData['searchCriteria'],
      };
    } else {
      postData = {
        "idToken": token,
        "data": jsonData,
      };
    }
    requestBody = jsonEncode(postData);
  } catch (e) {
    log(LogLevel.ERROR, 'Error preparing request data: $e');
    throw Exception('Request data preparation failed: $e');
  }

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
    // Return error code as string instead of throwing - allows graceful handling
    log(LogLevel.ERROR,
        'API Error: Status ${response.statusCode}. Response: ${response.body}');
    return response.statusCode.toString();
  }
}

/// Wrapper for sendjsontourl with elegant Florida-themed error handling
/// Returns a record with (success, data, errorMessage)
Future<({bool success, String? data, String? errorMessage})> sendjsontourlSafe(
    String jsonString, String token, String baseUrl) async {
  try {
    final result = await sendjsontourl(jsonString, token, baseUrl);

    // Check if result is an error code
    final statusCode = int.tryParse(result);
    if (statusCode != null && statusCode >= 400) {
      // Use Florida-themed messages for that sunshine state flair!
      // Using static version since we don't have BuildContext here
      final errorMessage = FloridaMessages.getMessageForStatusCodeStatic(statusCode);
      return (success: false, data: null, errorMessage: errorMessage);
    }

    return (success: true, data: result, errorMessage: null);
  } catch (e) {
    log(LogLevel.ERROR, 'sendjsontourlSafe caught exception: $e');
    // Use Florida-themed error messages based on error type
    // Using static version since we don't have BuildContext here
    final errorMessage = FloridaMessages.getMessageForErrorStatic(e);
    return (success: false, data: null, errorMessage: errorMessage);
  }
}
