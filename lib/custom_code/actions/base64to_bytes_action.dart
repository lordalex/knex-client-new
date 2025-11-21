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

Future<FFUploadedFile> base64toBytesAction(
    String base64, String fileName) async {
  try {
    String base64replaced = base64.replaceAll(RegExp(r'\s'), '');
    Uint8List bytes = base64Decode(base64replaced);
    return FFUploadedFile(
      name: fileName,
      bytes: bytes,
    );
  } catch (e) {
    print("Error decoding base64: $e");
    return FFUploadedFile(
        name: "error", bytes: Uint8List(0)); // Return an error file.
  }
}
