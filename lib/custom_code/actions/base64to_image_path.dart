// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:path_provider/path_provider.dart';

import 'dart:io' as Io;
import 'dart:convert';

Future<String?> base64toImagePath(String base64) async {
  // transform base64 argument to imagePath using dart:io
  print('base64toImagePath started');
  if (base64 == "") {
    print("Error: BASE64toIMAGEPATH: base64 argument is empty");
  }

  try {
    List<int> bytes = base64Decode(base64);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String imagePath =
        '$dir/image_${DateTime.now().millisecondsSinceEpoch}.png';
    await Io.File(imagePath).writeAsBytes(bytes);
    return 'file://' + imagePath;
  } catch (emptyHandler) {
    print("Error: BASE64toIMAGEPATH: exception catch");
    return '';
  }
}
