// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/schema/structs/index.dart'; // Imports backend data structures, including LatLng.
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart'; // Imports FlutterFlow theme utilities.
import '/flutter_flow/flutter_flow_util.dart'; // Imports general FlutterFlow utility functions.
import '/custom_code/actions/index.dart'; // Imports other custom actions defined in the project.
import '/flutter_flow/custom_functions.dart'; // Imports custom functions defined in the project.
import 'package:flutter/material.dart'; // Imports Flutter's material design widgets.

import 'dart:convert'; // Imports Dart's library for JSON encoding and decoding.
import 'dart:math' as math; // Imports Dart's math library, aliased as 'math'.
import 'package:location/location.dart'; // Imports the location package for accessing device GPS.

Future<List<String>> sortstringarraybyargs(
  // Defines an asynchronous function to calculate distances and sort.
  List<String>
      jsonStringList, // Accepts a list of strings, expected to be JSON objects.
  String
      latitudePropertyName, // Accepts the property name for latitude in the JSON objects.
  String
      longitudePropertyName, // Accepts the property name for longitude in the JSON objects.
  String
      resultingDistancePropertyName, // Accepts the property name for the new distance property.
  String
      unit, // Accepts the desired unit for the distance output (e.g., "kms", "miles").
  bool
      sortAscending, // Accepts a boolean to determine sort order (true for ascending).
  int verbosityLevel, // Accepts an integer for logging verbosity (0=none, 1=info, 2=item, 3=values, 4=debug).
  String?
      sortByPropertyName, // Accepts an optional property name to sort by; defaults to resultingDistancePropertyName if null.
) async {
  // Marks the function as asynchronous.

  // --- Verbosity Constants ---
  const int V_NONE = 0; // No logging.
  const int V_INFO = 1; // Basic function flow logging.
  const int V_ITEM_PROGRESS = 2; // Per-item processing logs.
  const int V_DETAILED_VALUES = 3; // Detailed values and parsing logs.
  const int V_DEBUG_INTERNAL = 4; // Internal calculation/parsing logs.

  final String effectiveSortByProperty = sortByPropertyName ??
      resultingDistancePropertyName; // Determines the actual property to sort by.

  if (verbosityLevel >= V_INFO)
    print(
        '[V_INFO] sortJsonListByDeviceDistance started. Verbosity: $verbosityLevel. Sorting: ${sortAscending ? "ASC" : "DESC"} by "$effectiveSortByProperty". Unit for distance: $unit.');

  double? _parseSortableValue(dynamic value, String propertyNameForLog) {
    // Helper to parse a value from JSON for sorting.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog: Raw value="$value" (type: ${value.runtimeType})');
    if (value == null) {
      // If value is null.
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog: Value is null.');
      return null;
    }
    if (value is num) {
      // If value is a number.
      double val = value.toDouble();
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog: Value is num, converted to $val.');
      return val;
    }
    if (value is String) {
      // If value is a string.
      // If the property being sorted IS the distance property, use specialized distance string parser.
      if (propertyNameForLog == resultingDistancePropertyName) {
        if (value.contains("Error")) {
          // If it's an error string from distance calculation.
          if (verbosityLevel >= V_DEBUG_INTERNAL)
            print(
                '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog (distance): Detected error string, returning null.');
          return null;
        }
        final parts = value.split(" "); // Splits "10.5 km".
        if (parts.isNotEmpty) {
          try {
            double parsedVal = double.parse(parts[0]);
            if (verbosityLevel >= V_DEBUG_INTERNAL)
              print(
                  '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog (distance): Parsed value=${parsedVal}');
            return parsedVal;
          } catch (e) {
            if (verbosityLevel >= V_DETAILED_VALUES)
              print(
                  '[V_DETAILED_VALUES] _parseSortableValue for $propertyNameForLog (distance): Error parsing numeric part of "$value": $e');
            return null; // Treat as unparsable for sorting if not a valid distance format.
          }
        }
        if (verbosityLevel >= V_DEBUG_INTERNAL)
          print(
              '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog (distance): No parts after split, returning null.');
        return null; // Not a recognized distance format for sorting.
      } else {
        // For other string properties, try direct double parsing.
        try {
          double parsedVal = double.parse(value.trim());
          if (verbosityLevel >= V_DEBUG_INTERNAL)
            print(
                '[V_DEBUG_INTERNAL] _parseSortableValue for "$propertyNameForLog": Parsed string to double: $parsedVal.');
          return parsedVal;
        } catch (e) {
          // If not parsable as double, it will be treated as a string in the sort comparison (handled later)
          // For now, returning null means it won't sort numerically here.
          if (verbosityLevel >= V_DETAILED_VALUES)
            print(
                '[V_DETAILED_VALUES] _parseSortableValue for "$propertyNameForLog": String not directly parsable to double, will sort as string or be null if preferred.');
          return null; // Or, decide to return a very large/small number if you want unparsable strings at ends
        }
      }
    }
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] _parseSortableValue for $propertyNameForLog: Value type ${value.runtimeType} not num or parsable String for numeric sort.');
    return null; // Not directly sortable as a number.
  } // End of _parseSortableValue function.

  double? _parseCoordinateValue(dynamic coordValue, String coordName) {
    // Defines a helper to parse coordinate value (String or num) to double.
    if (verbosityLevel >= V_DETAILED_VALUES)
      print(
          '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Raw value="$coordValue" (type: ${coordValue.runtimeType})');
    if (coordValue == null) {
      // Checks if the coordinate value is null.
      if (verbosityLevel >= V_DETAILED_VALUES)
        print(
            '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Value is null.');
      return null; // Returns null.
    }
    if (coordValue is num) {
      // Checks if it's already a number.
      double val = coordValue.toDouble(); // Converts to double.
      if (verbosityLevel >= V_DETAILED_VALUES)
        print(
            '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Value is num, converted to $val.');
      return val; // Returns the double.
    }
    if (coordValue is String) {
      // Checks if it's a string.
      if (coordValue.trim().isEmpty) {
        // Checks for empty string after trimming.
        if (verbosityLevel >= V_DETAILED_VALUES)
          print(
              '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Value is an empty string.');
        return null; // Returns null for empty string.
      }
      try {
        // Starts a try block for parsing the string.
        double val = double.parse(
            coordValue.trim()); // Parses the trimmed string to a double.
        if (verbosityLevel >= V_DETAILED_VALUES)
          print(
              '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Value is string, parsed to $val.');
        return val; // Returns the parsed double.
      } catch (e) {
        // Catches parsing errors.
        if (verbosityLevel >= V_DETAILED_VALUES)
          print(
              '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Error parsing string "$coordValue": $e');
        return null; // Returns null if string parsing fails.
      } // End of catch block for string parsing.
    } // End of string check.
    if (verbosityLevel >= V_DETAILED_VALUES)
      print(
          '[V_DETAILED_VALUES] _parseCoordinateValue for $coordName: Value type ${coordValue.runtimeType} not num or String.');
    return null; // Returns null if the type is neither num nor String.
  } // End of _parseCoordinateValue function.

  String _calculateDistanceAndFormat(
    // Defines a synchronous helper function to calculate and format distance.
    double lat1, // Accepts the first latitude as a double.
    double lon1, // Accepts the first longitude as a double.
    double lat2, // Accepts the second latitude as a double.
    double lon2, // Accepts the second longitude as a double.
    String unitInput, // Accepts the desired unit for the distance output.
  ) {
    // Start of the _calculateDistanceAndFormat function body.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] _calculateDistanceAndFormat: Inputs: lat1=$lat1, lon1=$lon1, lat2=$lat2, lon2=$lon2, unit=$unitInput');

    double _toRadians(double degrees) {
      // Defines a nested helper function to convert degrees to radians.
      return degrees *
          math.pi /
          180; // Returns the radian equivalent of the input degrees.
    } // End of the _toRadians function.

    const double earthRadius =
        6371000; // Defines the Earth's radius in meters as a constant.

    double lat1Rad =
        _toRadians(lat1); // Converts the first latitude to radians.
    double lon1Rad =
        _toRadians(lon1); // Converts the first longitude to radians.
    double lat2Rad =
        _toRadians(lat2); // Converts the second latitude to radians.
    double lon2Rad =
        _toRadians(lon2); // Converts the second longitude to radians.

    double dlon = lon2Rad -
        lon1Rad; // Calculates the difference in longitudes (in radians).
    double dlat = lat2Rad -
        lat1Rad; // Calculates the difference in latitudes (in radians).

    double a = math.pow(math.sin(dlat / 2),
            2) + // Calculates the 'a' part of the Haversine formula.
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.pow(math.sin(dlon / 2), 2); // Continues calculation of 'a'.
    double c = 2 *
        math.atan2(
            math.sqrt(a),
            math.sqrt(1 -
                a)); // Calculates the 'c' part (angular distance) of the Haversine formula.

    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] Haversine intermediate: dLatRad=$dlat, dLonRad=$dlon, a=$a, c=$c');

    double distanceInMeters =
        earthRadius * c; // Calculates the distance in meters.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print('[V_DEBUG_INTERNAL] Haversine result (meters): $distanceInMeters');

    String unitLower = unitInput
        .toLowerCase(); // Converts the input unit string to lowercase for easier comparison.
    String formattedDistance; // Declares string for the formatted distance.

    if (unitLower == 'kms' || unitLower == 'meters') {
      // Checks if the desired unit is kilometers or meters.
      if (distanceInMeters >= 1000) {
        // Checks if the distance is 1000 meters or more.
        formattedDistance =
            '${(distanceInMeters / 1000).toStringAsFixed(1)} km'; // Formats distance in kilometers.
      } else {
        // If distance is less than 1000 meters.
        formattedDistance =
            '${distanceInMeters.toStringAsFixed(0)} m'; // Formats distance in meters.
      } // End of kilometers/meters unit condition.
    } else if (unitLower == 'imperial' ||
        unitLower == 'miles' ||
        unitLower == 'mi') {
      // Checks if the desired unit is imperial or miles.
      double miles = distanceInMeters *
          0.000621371; // Converts distance from meters to miles.
      if (miles >= 0.1) {
        // Checks if the distance in miles is 0.1 or more.
        formattedDistance =
            '${miles.toStringAsFixed(1)} mi'; // Formats distance in miles.
      } else {
        // If distance in miles is less than 0.1.
        double feet = distanceInMeters *
            3.28084; // Converts distance from meters to feet.
        formattedDistance =
            '${feet.toStringAsFixed(0)} ft'; // Formats distance in feet.
      } // End of miles/feet unit condition.
    } else {
      // If the unit is not recognized, defaults to kilometers/meters.
      if (verbosityLevel >= V_DETAILED_VALUES)
        print(
            "[V_DETAILED_VALUES] Unrecognized unit '$unitInput', defaulting to km/m."); // Prints a message about defaulting the unit.
      if (distanceInMeters >= 1000) {
        // Checks if the distance is 1000 meters or more (default case).
        formattedDistance =
            '${(distanceInMeters / 1000).toStringAsFixed(1)} km'; // Formats distance in kilometers (default).
      } else {
        // If distance is less than 1000 meters (default case).
        formattedDistance =
            '${distanceInMeters.toStringAsFixed(0)} m'; // Formats distance in meters (default).
      } // End of default unit condition.
    } // End of unit conversion block.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] _calculateDistanceAndFormat: Returning formatted distance="$formattedDistance"');
    return formattedDistance; // Returns the formatted distance string.
  } // End of _calculateDistanceAndFormat function.

  Future<LocationData?> _getDeviceLocation() async {
    // Defines an asynchronous helper function to get the device's current location data.
    if (verbosityLevel >= V_INFO)
      print(
          '[V_INFO] _getDeviceLocation: Attempting to fetch device location...');
    Location locationService =
        Location(); // Creates an instance of the Location service.
    try {
      // Starts a try block for error handling during location fetching.
      bool serviceEnabled = await locationService
          .serviceEnabled(); // Checks if location services are enabled on the device.
      if (verbosityLevel >= V_DETAILED_VALUES)
        print(
            '[V_DETAILED_VALUES] _getDeviceLocation: Service enabled check: $serviceEnabled');
      if (!serviceEnabled) {
        // If location services are not enabled.
        if (verbosityLevel >= V_INFO)
          print(
              '[V_INFO] _getDeviceLocation: Location service not enabled, requesting service...');
        serviceEnabled = await locationService
            .requestService(); // Requests the user to enable location services.
        if (verbosityLevel >= V_INFO)
          print(
              '[V_INFO] _getDeviceLocation: Service request result: $serviceEnabled');
        if (!serviceEnabled) {
          // If the user still doesn't enable services.
          if (verbosityLevel >= V_INFO)
            print(
                '[V_INFO] _getDeviceLocation: Location service not enabled by user after request.');
          return null; // Returns null indicating failure.
        } // End of service request check.
      } // End of service enabled check.

      PermissionStatus permissionGranted = await locationService
          .hasPermission(); // Checks if the app has location permission.
      if (verbosityLevel >= V_DETAILED_VALUES)
        print(
            '[V_DETAILED_VALUES] _getDeviceLocation: Permission status: $permissionGranted');
      if (permissionGranted == PermissionStatus.denied) {
        // If permission is denied.
        if (verbosityLevel >= V_INFO)
          print(
              '[V_INFO] _getDeviceLocation: Location permission denied, requesting permission...');
        permissionGranted = await locationService
            .requestPermission(); // Requests location permission from the user.
        if (verbosityLevel >= V_INFO)
          print(
              '[V_INFO] _getDeviceLocation: Permission request result: $permissionGranted');
        if (permissionGranted != PermissionStatus.granted) {
          // If permission is not granted after request.
          if (verbosityLevel >= V_INFO)
            print(
                '[V_INFO] _getDeviceLocation: Location permission denied by user after request.');
          return null; // Returns null indicating failure.
        } // End of permission request check.
      } // End of permission granted check.

      LocationData locData = await locationService
          .getLocation(); // Fetches and returns the current location data.
      if (verbosityLevel >= V_INFO)
        print(
            '[V_INFO] _getDeviceLocation: Location fetched: Lat=${locData.latitude}, Lon=${locData.longitude}');
      return locData; // Returns the location data.
    } catch (e) {
      // Catches any exception during location fetching.
      if (verbosityLevel >= V_ITEM_PROGRESS)
        print(
            '[V_ITEM_PROGRESS] _getDeviceLocation: Error fetching device location: $e');
      return null; // Returns null in case of an error.
    } // End of catch block for location fetching.
  } // End of _getDeviceLocation function.

  if (jsonStringList == null || jsonStringList.isEmpty) {
    // Checks if the input list of JSON strings is null or empty.
    if (verbosityLevel >= V_INFO)
      print(
          '[V_INFO] Input jsonStringList is null or empty. Returning empty list.');
    return []; // Returns an empty list.
  } // End of input list check.
  if (verbosityLevel >= V_INFO)
    print('[V_INFO] Processing ${jsonStringList.length} JSON strings.');

  final LocationData? deviceLocationData =
      await _getDeviceLocation(); // Asynchronously fetches the device's current location.
  final String deviceErrorMessage =
      'Error: Device Location Unavailable'; // Defines a constant error message for device location issues.

  double? deviceLat; // Initializes nullable double for device latitude.
  double? deviceLon; // Initializes nullable double for device longitude.

  if (deviceLocationData != null &&
      deviceLocationData.latitude != null &&
      deviceLocationData.longitude != null) {
    // Checks if device location data is valid.
    deviceLat = deviceLocationData.latitude; // Assigns device latitude.
    deviceLon = deviceLocationData.longitude; // Assigns device longitude.
    if (verbosityLevel >= V_INFO)
      print('[V_INFO] Device coordinates set: Lat=$deviceLat, Lon=$deviceLon');
  } else {
    // If device location data is invalid or null.
    if (verbosityLevel >= V_INFO)
      print('[V_INFO] Device location is unavailable.');
  } // End device location data assignment.

  List<Map<String, dynamic>> processedObjects =
      []; // Initializes a list to store processed JSON objects (as Maps).
  int itemIndex = 0; // Initializes item index for logging.

  for (final jsonString in jsonStringList) {
    // Iterates over each JSON string in the input list.
    itemIndex++; // Increments item index.
    if (verbosityLevel >= V_ITEM_PROGRESS)
      print(
          '[V_ITEM_PROGRESS] Processing item #$itemIndex: "${jsonString?.substring(0, math.min(jsonString.length, 50)) ?? "null_string"}${jsonString != null && jsonString.length > 50 ? "..." : ""}"');

    try {
      // Starts a try block for processing each JSON string.
      Map<String, dynamic> jsonObject = jsonDecode(jsonString ??
          '{}'); // Decodes the current JSON string (or empty object if null).
      String
          calculatedDistanceStr; // Declares a string to store the calculated distance.

      if (deviceLat == null || deviceLon == null) {
        // Checks if device location was unavailable.
        calculatedDistanceStr =
            deviceErrorMessage; // Assigns the device error message.
        if (verbosityLevel >= V_ITEM_PROGRESS)
          print(
              '[V_ITEM_PROGRESS] Item #$itemIndex: Device location unavailable, distance set to error string.');
      } else {
        // If device location is available.
        dynamic rawTargetLat = jsonObject[
            latitudePropertyName]; // Retrieves the raw value of the latitude property.
        dynamic rawTargetLon = jsonObject[
            longitudePropertyName]; // Retrieves the raw value of the longitude property.
        if (verbosityLevel >= V_DETAILED_VALUES)
          print(
              '[V_DETAILED_VALUES] Item #$itemIndex: Raw target lat ("$latitudePropertyName"): "$rawTargetLat", Raw target lon ("$longitudePropertyName"): "$rawTargetLon"');

        double? targetLat = _parseCoordinateValue(rawTargetLat,
            '$latitudePropertyName for item #$itemIndex'); // Parses the target latitude value to double.
        double? targetLon = _parseCoordinateValue(rawTargetLon,
            '$longitudePropertyName for item #$itemIndex'); // Parses the target longitude value to double.
        if (verbosityLevel >= V_DETAILED_VALUES)
          print(
              '[V_DETAILED_VALUES] Item #$itemIndex: Parsed target lat: $targetLat, Parsed target lon: $targetLon');

        if (targetLat != null && targetLon != null) {
          // Checks if both target latitude and longitude were successfully parsed.
          calculatedDistanceStr = _calculateDistanceAndFormat(
              // Calls the helper to calculate and format distance.
              deviceLat,
              deviceLon,
              targetLat,
              targetLon,
              unit); // Uses device and target coordinates.
          if (verbosityLevel >= V_ITEM_PROGRESS)
            print(
                '[V_ITEM_PROGRESS] Item #$itemIndex: Calculated distance: "$calculatedDistanceStr"');
        } else {
          // If target coordinates are missing or invalid after parsing.
          calculatedDistanceStr =
              "Error: Invalid or missing target coordinates for '$latitudePropertyName' or '$longitudePropertyName'"; // Sets an error message.
          if (verbosityLevel >= V_ITEM_PROGRESS)
            print(
                '[V_ITEM_PROGRESS] Item #$itemIndex: Target coordinates missing/invalid, distance set to error string.');
        } // End of distance calculation or error assignment.
      } // End of device location check for calculation.
      jsonObject[resultingDistancePropertyName] =
          calculatedDistanceStr; // Adds the calculated distance string as a new property.
      processedObjects
          .add(jsonObject); // Adds the processed JSON object (Map) to the list.
    } catch (e) {
      // Catches any exception during the processing of a single JSON string.
      if (verbosityLevel >= V_ITEM_PROGRESS)
        print(
            '[V_ITEM_PROGRESS] Error processing JSON string for item #$itemIndex ("${jsonString?.substring(0, math.min(jsonString.length, 30)) ?? "null_string"}..."): $e');
      Map<String, dynamic> errorObject =
          {}; // Creates an empty map for the error object.
      try {
        // Tries to decode the original string again to preserve other fields if possible.
        errorObject = jsonDecode(jsonString ??
            '{}'); // Decodes original or empty JSON for the error object.
      } catch (_) {} // Ignores error if decoding fails again, uses empty map.
      errorObject[resultingDistancePropertyName] =
          'Error: Invalid JSON Structure or Unparsable'; // Adds distance error message.
      // Also ensure the sort-by property exists if it's different, or set it to an error/null indicator for sorting
      if (effectiveSortByProperty != resultingDistancePropertyName &&
          !errorObject.containsKey(effectiveSortByProperty)) {
        errorObject[effectiveSortByProperty] =
            null; // Or some other indicator for sorting
      }
      processedObjects.add(errorObject); // Adds the error object to the list.
    } // End of try-catch block for a single JSON string.
  } // End of loop iterating through jsonStringList.

  if (verbosityLevel >= V_INFO)
    print(
        '[V_INFO] Sorting ${processedObjects.length} processed objects by "$effectiveSortByProperty"...');
  processedObjects.sort((a, b) {
    // Sorts the list of processed JSON objects.
    dynamic valA_raw = a[
        effectiveSortByProperty]; // Gets raw value for sort property from object a.
    dynamic valB_raw = b[
        effectiveSortByProperty]; // Gets raw value for sort property from object b.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] Sort compare on "$effectiveSortByProperty": A_raw="$valA_raw", B_raw="$valB_raw"');

    double? valA_num = _parseSortableValue(
        valA_raw, effectiveSortByProperty); // Parses value A for numeric sort.
    double? valB_num = _parseSortableValue(
        valB_raw, effectiveSortByProperty); // Parses value B for numeric sort.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] Sort compare (parsed numeric): A_val_num=$valA_num, B_val_num=$valB_num');

    // Primary numeric sort if both values are numbers (or parsable as numbers)
    if (valA_num != null && valB_num != null) {
      // If both are successfully parsed as numbers.
      int comparisonResult = sortAscending
          ? valA_num.compareTo(valB_num)
          : valB_num.compareTo(valA_num);
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] Sort compare (numeric): Result $comparisonResult.');
      return comparisonResult;
    }
    // Handle cases where one or both are not numbers (e.g., strings, errors)
    if (valA_num == null && valB_num == null) {
      // If both are non-numeric or unparsable as numeric.
      // Fallback to string comparison for non-numeric types
      String valA_str =
          valA_raw?.toString() ?? ""; // Convert to string, default to empty.
      String valB_str =
          valB_raw?.toString() ?? ""; // Convert to string, default to empty.
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] Sort compare (both non-numeric, fallback to string): A_str="$valA_str", B_str="$valB_str"');
      int comparisonResult = sortAscending
          ? valA_str.compareTo(valB_str)
          : valB_str.compareTo(valA_str);
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] Sort compare (string): Result $comparisonResult.');
      return comparisonResult;
    }
    // If one is numeric and the other is not, numeric values typically come before strings or nulls.
    // (Or however you want to prioritize them - this pushes null/non-numeric to one end).
    if (valA_num == null) {
      // A is non-numeric/null, B is numeric.
      int res = sortAscending
          ? 1
          : -1; // Non-numeric A goes after numeric B if ascending.
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] Sort compare (A non-numeric, B numeric): Result $res.');
      return res;
    }
    if (valB_num == null) {
      // B is non-numeric/null, A is numeric.
      int res = sortAscending
          ? -1
          : 1; // Non-numeric B goes after numeric A if ascending.
      if (verbosityLevel >= V_DEBUG_INTERNAL)
        print(
            '[V_DEBUG_INTERNAL] Sort compare (B non-numeric, A numeric): Result $res.');
      return res;
    }

    // Should not be reached if logic above is complete for numeric/non-numeric combinations.
    if (verbosityLevel >= V_DEBUG_INTERNAL)
      print(
          '[V_DEBUG_INTERNAL] Sort compare: Fallback to 0 (should not happen).');
    return 0;
  }); // End of sorting logic.

  if (verbosityLevel >= V_INFO)
    print(
        '[V_INFO] sortJsonListByDeviceDistance finished. Returning ${processedObjects.length} items.');
  return processedObjects
      .map((obj) => jsonEncode(obj))
      .toList(); // Converts sorted Maps back to JSON strings and returns the list.
} // End of sortJsonListByDeviceDistance function.
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
