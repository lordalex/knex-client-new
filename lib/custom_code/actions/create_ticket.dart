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
import '/demo/demo_config.dart';

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

class TicketDataResponse {
  final bool success;
  final String message;
  final dynamic data;
  final String? error;
  final int? statusCode;

  TicketDataResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.statusCode,
  });

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        if (data != null) 'data': data,
        if (error != null) 'error': error,
        if (statusCode != null) 'statusCode': statusCode,
      };
}

Future<String> createTicket(String firebaseUrl, String token, String site,
    String vehicleInfo, String mail, List<String> notes) async {
  if (DemoConfig.isDemo) {
    log(LogLevel.INFO, '[DEMO] createTicket intercepted');
    await Future.delayed(const Duration(milliseconds: 300));
    return jsonEncode(TicketDataResponse(
      success: true,
      message: 'Ticket created successfully',
      data: {
        'id': 'demo_ticket_${DateTime.now().millisecondsSinceEpoch}',
        'PIN': '8842',
        'status': 'Parked',
        'siteId': site,
      },
      statusCode: 200,
    ).toJson());
  }
  log(LogLevel.INFO, 'Starting createTicket operation');
  try {
    // 1. Pre-computation and Validation
    if (token.isEmpty) {
      log(LogLevel.ERROR, 'Auth token is empty.');
      throw Exception('Auth token cannot be empty.');
    }
    if (firebaseUrl.isEmpty) {
      log(LogLevel.ERROR, 'Firebase URL is empty.');
      throw Exception('Firebase URL cannot be empty.');
    }

    Uri uri;
    try {
      uri = Uri.parse(firebaseUrl);
      log(LogLevel.DEBUG, 'URI parsed successfully: $uri');
    } catch (e) {
      log(LogLevel.ERROR, 'Error parsing URI: $e');
      throw Exception('URI parsing failed: $e');
    }

    final body = {
      'idToken': token,
      "data": {
        "siteId": site.replaceAll('"', ""),
        "mail": mail,
        "vehicleInfo": jsonDecode(vehicleInfo),
        "notes": notes
      }
    };
    final headers = {'Content-Type': 'application/json'};

    // 2. Pre-API Call Logging
    log(LogLevel.INFO, 'Preparing to send HTTP POST request to $uri');
    log(LogLevel.DEBUG, 'Request Headers: ${jsonEncode(headers)}');
    log(LogLevel.DEBUG, 'Request Body: ${jsonEncode(body)}');

    // 3. API Call
    final response = await _sendRequestWithRetry(
      uri: uri,
      headers: headers,
      body: body,
    );

    // 4. Post-API Call Logging
    log(LogLevel.INFO,
        'Received response from $uri with status code: ${response.statusCode}');
    log(LogLevel.DEBUG, 'Response Body: ${response.body}');

    // 5. Post-computation and Response Handling
    final ticketResponse = _processResponse(response);
    log(LogLevel.INFO, 'Operation completed successfully');
    return jsonEncode(ticketResponse.toJson());
  } catch (e) {
    log(LogLevel.ERROR, 'Error in createTicket: $e');
    return jsonEncode(TicketDataResponse(
      success: false,
      message: 'Operation failed',
      error: e.toString(),
    ).toJson());
  }
}

// Helper function to send request with retry mechanism
Future<http.Response> _sendRequestWithRetry({
  required Uri uri,
  required Map<String, String> headers,
  required Map<String, dynamic> body,
  int maxRetries = 3,
  Duration retryDelay = const Duration(seconds: 1),
}) async {
  int attempts = 0;
  while (attempts < maxRetries) {
    try {
      log(LogLevel.INFO,
          'Sending HTTP request (attempt ${attempts + 1}/$maxRetries)');
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode < 500) {
        return response;
      }
      attempts++;
      if (attempts < maxRetries) {
        log(LogLevel.WARNING,
            'Request failed with ${response.statusCode}, retrying...');
        await Future.delayed(retryDelay * attempts);
      }
    } on http.ClientException catch (e) {
      log(LogLevel.ERROR, 'Network error: $e');
      attempts++;
      if (attempts >= maxRetries) rethrow;
      await Future.delayed(retryDelay * attempts);
    }
  }
  throw Exception('Max retry attempts reached');
}

// Helper function to process HTTP response
TicketDataResponse _processResponse(http.Response response) {
  log(LogLevel.INFO, 'Processing response: ${response.statusCode}');
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return TicketDataResponse(
      success: true,
      message: 'Ticket data updated successfully',
      data: jsonDecode(response.body),
      statusCode: response.statusCode,
    );
  }

  return TicketDataResponse(
    success: false,
    message: 'Failed to update ticket data: ${response.reasonPhrase}',
    error: response.body,
    statusCode: response.statusCode,
  );
}
