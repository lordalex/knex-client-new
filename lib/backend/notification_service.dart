import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import 'package:custom_notification_library_68aamd/custom_code/actions/custom_toastification.dart';
// Depending on how custom_notification_library_68aamd exports nav.dart, check if we need direct import
// For appNavigatorKey, we can try importing from the project structure
// Assuming knex structure: lib/flutter_flow/nav/nav.dart
import '../../flutter_flow/nav/nav.dart';

class NotificationService {
  static Map<String, String> _messages = {};

  static Future<void> initialize() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/jsons/api_messages.json');
      _messages = Map<String, String>.from(json.decode(jsonString));
    } catch (e) {
      print('Error loading api_messages.json: $e');
    }
  }

  static void onApiResponse(ApiCallResponse response, String callName) {
    // Only handle errors for now, or successful actions that need feedback.
    if (!response.succeeded) {
      final statusCode = response.statusCode.toString();

      // Translation logic:
      // 1. Try generic status code (e.g. "500")
      // 2. Fallback to default error
      String message = _messages[statusCode] ??
          _messages['default_error'] ??
          'An error occurred';

      // Optionally append original error message if available and safe
      // if (response.jsonBody is Map && response.jsonBody['error'] != null) {
      //   message += ": ${response.jsonBody['error']}";
      // }

      final context = appNavigatorKey.currentContext;
      if (context != null) {
        customToastification(context, 'Error $statusCode', message, 'error',
            'fillColored', 'topRight', false);
      } else {
        print(
            'NotificationService: Context is null, cannot show toast for $callName');
      }
    } else {
      // Success case
      // If we want to show successes, we can do it here.
      // For now, let's log it.
      print(
          'NotificationService: Call $callName succeeded with ${response.statusCode}');
    }
  }
}
