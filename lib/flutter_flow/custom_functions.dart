import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String getkeyfromjsonstring(
  String string,
  String key,
) {
  print(string);
  print(key);
  print("*************");
  if (string.length < 2) return "";
  try {
    final json = jsonDecode(string);
    if (json is Map) {
      if (json.containsKey(key)) {
        return jsonEncode(json[key]);
      }
    } else if (json is List) {
      for (final element in json) {
        if (element is Map && element.containsKey(key)) {
          return jsonEncode(element[key]);
        }
      }
    }
  } catch (e) {
    print("Error decoding JSON: $e");
  }
  return "";
}

String getelementsfromjson(String inpuString) {
  try {
    dynamic json = jsonDecode(inpuString);
    if (json is List) {
      if (json.isNotEmpty) {
        return jsonEncode(json.last);
      } else {
        return "[]"; // Return empty array as string if the list is empty
      }
    } else {
      return jsonEncode(
          json); // Use jsonEncode to ensure it's a string representation
    }
  } catch (e) {
    print("Error decoding JSON: $e");
    return "";
  }
}

List<String> jsontoarray(String jsonString) {
  try {
    List<Map<String, dynamic>> jsonArray =
        List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    List<String> stringRepresentations =
        jsonArray.map((map) => jsonEncode(map)).toList();
    return stringRepresentations;
  } catch (e) {
    // Return a list with the error message if something goes wrong
    return ['Error: $e'];
  }
}

String asthecrowflies(
  String lat1s,
  String lon1s,
  String lat2s,
  String lon2s,
  String unit,
) {
  double _toRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  double lat1, lat2, lon1, lon2;
  try {
    lat1 = double.parse(lat1s);
    lat2 = double.parse(lat2s);
    lon1 = double.parse(lon1s);
    lon2 = double.parse(lon2s);
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error fetching location: $e');
    return ""; // Return empty string in case of an error
  }
  const double earthRadius = 6371000; // Radius of the earth in meters

  // Convert latitude and longitude from degrees to radians
  double lat1Rad = _toRadians(lat1);
  double lon1Rad = _toRadians(lon1);
  double lat2Rad = _toRadians(lat2);
  double lon2Rad = _toRadians(lon2);

  // Haversine formula
  double dlon = lon2Rad - lon1Rad;
  double dlat = lat2Rad - lat1Rad;

  double a = math.pow(math.sin(dlat / 2), 2) +
      math.cos(lat1Rad) * math.cos(lat2Rad) * math.pow(math.sin(dlon / 2), 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  double distance = earthRadius * c; // Distance in meters
  String unitLower = unit.toLowerCase();
  double meters = distance;
  if (unitLower == 'kms' || unitLower == 'meters') {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(2)} km';
    } else if (meters >= 1) {
      return '${meters.toStringAsFixed(2)} m';
    } else {
      return '${(meters * 100).toStringAsFixed(2)} cm';
    }
  } else if (unitLower == 'imperial' ||
      unitLower == 'miles' ||
      unitLower == 'mi') {
    double miles = meters * 0.000621371;
    if (miles >= 1) {
      return '${miles.toStringAsFixed(2)} mi';
    } else if (meters >= 1609.34 * (1 / 3)) {
      return '${miles.toStringAsFixed(2)} mi';
    } else if (meters >= 1) {
      double feet = meters * 3.28084;
      return '${feet.toStringAsFixed(2)} ft';
    } else {
      return '${meters.toStringAsFixed(2)} m';
    }
  } else {
    return '${meters.toStringAsFixed(2)} m';
  }
}

String tostr(String element) {
  print(element.toString());
  return element.toString().replaceAll(RegExp(r'[\"\{\}]'), '');
}

String extractTime(String timeStr) {
  String timestring;
  try {
    timestring = jsonDecode(timeStr);
    print("[1/5] Starting date/time processing for: $timestring");

    // --- DateTime Parsing Block ---
    DateTime parsedDate;
    try {
      print("[2/5] Attempting to parse ISO string...");
      parsedDate = DateTime.parse(timestring);
      print("✅ Successfully parsed date: $parsedDate");
    } catch (parseError, stackTrace) {
      print("⛔ Critical parse error: $parseError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'DATE_PARSE_FAILURE',
        'message': 'Failed to parse input string as DateTime',
        'details': parseError.toString(),
        'input': timestring,
        'stage': 'initial_parsing'
      });
    }

    // --- UTC Conversion Block ---
    DateTime utcDate;
    try {
      print("[3/5] Converting to UTC...");
      utcDate = parsedDate.toUtc();
      print("✅ UTC conversion successful: $utcDate");
    } catch (conversionError, stackTrace) {
      print("⛔ UTC conversion failed: $conversionError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'UTC_CONVERSION_FAILURE',
        'message': 'Failed to convert local date to UTC',
        'original_date': parsedDate.toString(),
        'details': conversionError.toString(),
        'stage': 'utc_conversion'
      });
    }

    // --- Date Formatting Block ---
    String formattedDate;
    try {
      print("[4/5] Formatting date...");
      String month = DateFormat('MMMM').format(utcDate);
      formattedDate = '${month} '
          '${utcDate.day}, ${utcDate.year}';
      print("✅ Date formatted: $formattedDate");
    } catch (formatError, stackTrace) {
      print("⛔ Date formatting failed: $formatError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'DATE_FORMAT_FAILURE',
        'message': 'Failed to format date components',
        'utc_date': utcDate.toString(),
        'details': formatError.toString(),
        'stage': 'date_formatting'
      });
    }

    // --- Time Formatting Block ---
    String formattedTime;
    try {
      print("[5/5] Formatting time...");
      final hour = utcDate.hour;
      final period = hour >= 12 ? 'PM' : 'AM';
      final twelveHour = hour % 12 == 0 ? 12 : hour % 12;

      formattedTime = '${twelveHour.toString().padLeft(2, '0')}:'
          '${utcDate.minute.toString().padLeft(2, '0')} $period';
      print("✅ Time formatted: $formattedTime");
    } catch (formatError, stackTrace) {
      print("⛔ Time formatting failed: $formatError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'TIME_FORMAT_FAILURE',
        'message': 'Failed to format time components',
        'utc_date': utcDate.toString(),
        'details': formatError.toString(),
        'stage': 'time_formatting'
      });
    }

    // --- Time Difference Calculation ---
    String timeDifference;
    try {
      print("[6/6] Calculating time difference...");
      final now = DateTime.now().toUtc();
      final difference = now.difference(utcDate);

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      final seconds = difference.inSeconds % 60;

      timeDifference = '${days.toString().padLeft(2, '0')}d '
          '${hours.toString().padLeft(2, '0')}h '
          '${minutes.toString().padLeft(2, '0')}m '
          '${seconds.toString().padLeft(2, '0')}s';
      print("✅ Time difference calculated: $timeDifference");
    } catch (differenceError, stackTrace) {
      print("⛔ Time difference calculation failed: $differenceError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'TIME_DIFFERENCE_FAILURE',
        'message': 'Failed to calculate time difference',
        'utc_date': utcDate.toString(),
        'details': differenceError.toString(),
        'stage': 'time_difference'
      });
    }

    // --- Final Output Assembly ---
    try {
      print("🔄 Assembling final result...");
      final result = {
        'date': formattedDate,
        'time': formattedTime,
        'time_difference': timeDifference,
        'utc_timestamp': utcDate.toIso8601String(),
        'success': true
      };
      print("🎉 Full processing completed successfully");
      return jsonEncode(result);
    } catch (assemblyError, stackTrace) {
      print("⛔ Result assembly failed: $assemblyError");
      print("Stack trace:\n$stackTrace");
      return jsonEncode({
        'error': 'RESULT_ASSEMBLY_FAILURE',
        'message': 'Failed to create final result object',
        'formatted_date': formattedDate,
        'formatted_time': formattedTime,
        'time_difference': timeDifference,
        'details': assemblyError.toString(),
        'stage': 'result_assembly'
      });
    }
  } catch (unexpectedError, stackTrace) {
    print("💥 Unexpected top-level error: $unexpectedError");
    print("Stack trace:\n$stackTrace");
    return jsonEncode({
      'error': 'UNEXPECTED_FAILURE',
      'message': 'Unknown error occurred in processing pipeline',
      'details': unexpectedError.toString(),
      'stage': 'unknown'
    });
  }
}

String parseBytesToBase64(FFUploadedFile filePhoto) {
  // convert bytes to base64 string
  return "";
}

List<String> statesList() {
  List<String> estadosUSA = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Carolina del Norte",
    "Carolina del Sur",
    "Colorado",
    "Connecticut",
    "Dakota del Norte",
    "Dakota del Sur",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Luisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Misisipi",
    "Misuri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "Nuevo México",
    "New York",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pensilvania",
    "Rhode Island",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "West Virginia",
    "Washington",
    "Wisconsin",
    "Wyoming"
  ];

  return estadosUSA;
}

List<String> citiesList(String? state) {
  // take state and return the static array list in the custom function
  switch (state) {
    case 'Alabama':
      return ['Birmingham', 'Montgomery', 'Mobile', 'Huntsville', 'Tuscaloosa'];
    case 'Alaska':
      return ['Anchorage', 'Fairbanks', 'Juneau', 'Sitka', 'Ketchikan'];
    case 'Arizona':
      return ['Phoenix', 'Tucson', 'Mesa', 'Chandler', 'Scottsdale'];
    case 'Arkansas':
      return [
        'Little Rock',
        'Fort Smith',
        'Fayetteville',
        'Springdale',
        'Jonesboro'
      ];
    case 'California':
      return [
        'Los Angeles',
        'San Francisco',
        'San Diego',
        'San Jose',
        'Sacramento'
      ];
    case 'Carolina del Norte':
      return ['Charlotte', 'Raleigh', 'Greensboro', 'Durham', 'Winston-Salem'];
    case 'Carolina del Sur':
      return [
        'Columbia',
        'Charleston',
        'North Charleston',
        'Mount Pleasant',
        'Rock Hill'
      ];
    case 'Colorado':
      return [
        'Denver',
        'Colorado Springs',
        'Aurora',
        'Fort Collins',
        'Lakewood'
      ];
    case 'Connecticut':
      return ['Bridgeport', 'New Haven', 'Stamford', 'Hartford', 'Waterbury'];
    case 'Dakota del Norte':
      return ['Fargo', 'Bismarck', 'Grand Forks', 'Minot', 'West Fargo'];
    case 'Dakota del Sur':
      return [
        'Sioux Falls',
        'Rapid City',
        'Aberdeen',
        'Watertown',
        'Brookings'
      ];
    case 'Delaware':
      return ['Wilmington', 'Dover', 'Newark', 'Middletown', 'Smyrna'];
    case 'Florida':
      return [
        'Jacksonville',
        'Miami',
        'Tampa',
        'Orlando',
        'St. Petersburg',
        'Naples'
      ];
    case 'Georgia':
      return ['Atlanta', 'Columbus', 'Augusta', 'Savannah', 'Athens'];
    case 'Hawaii':
      return ['Honolulu', 'Hilo', 'Kailua', 'Pearl City', 'Kahului'];
    case 'Idaho':
      return ['Boise', 'Meridian', 'Nampa', 'Idaho Falls', 'Pocatello'];
    case 'Illinois':
      return ['Chicago', 'Aurora', 'Rockford', 'Joliet', 'Naperville'];
    case 'Indiana':
      return [
        'Indianapolis',
        'Fort Wayne',
        'Evansville',
        'South Bend',
        'Carmel'
      ];
    case 'Iowa':
      return [
        'Des Moines',
        'Cedar Rapids',
        'Davenport',
        'Sioux City',
        'Waterloo'
      ];
    case 'Kansas':
      return ['Wichita', 'Overland Park', 'Kansas City', 'Olathe', 'Topeka'];
    case 'Kentucky':
      return [
        'Louisville',
        'Lexington',
        'Bowling Green',
        'Owensboro',
        'Covington'
      ];
    case 'Luisiana':
      return [
        'New Orleans',
        'Baton Rouge',
        'Shreveport',
        'Lafayette',
        'Lake Charles'
      ];
    case 'Maine':
      return ['Portland', 'Lewiston', 'Bangor', 'South Portland', 'Auburn'];
    case 'Maryland':
      return [
        'Baltimore',
        'Columbia',
        'Germantown',
        'Silver Spring',
        'Waldorf'
      ];
    case 'Massachusetts':
      return ['Boston', 'Worcester', 'Springfield', 'Lowell', 'Cambridge'];
    case 'Michigan':
      return [
        'Detroit',
        'Grand Rapids',
        'Warren',
        'Sterling Heights',
        'Ann Arbor'
      ];
    case 'Minnesota':
      return [
        'Minneapolis',
        'Saint Paul',
        'Rochester',
        'Duluth',
        'Bloomington'
      ];
    case 'Misisipi':
      return ['Jackson', 'Gulfport', 'Southaven', 'Hattiesburg', 'Biloxi'];
    case 'Misuri':
      return [
        'Kansas City',
        'St. Louis',
        'Springfield',
        'Columbia',
        'Independence'
      ];
    case 'Montana':
      return ['Billings', 'Missoula', 'Great Falls', 'Bozeman', 'Butte'];
    case 'Nebraska':
      return ['Omaha', 'Lincoln', 'Bellevue', 'Grand Island', 'Kearney'];
    case 'Nevada':
      return ['Las Vegas', 'Henderson', 'Reno', 'North Las Vegas', 'Sparks'];
    case 'New Hampshire':
      return ['Manchester', 'Nashua', 'Concord', 'Derry', 'Rochester'];
    case 'New Jersey':
      return ['Newark', 'Jersey City', 'Paterson', 'Elizabeth', 'Edison'];
    case 'Nuevo México':
      return ['Albuquerque', 'Las Cruces', 'Rio Rancho', 'Santa Fe', 'Roswell'];
    case 'New York':
      return ['New York City', 'Buffalo', 'Rochester', 'Yonkers', 'Syracuse'];
    case 'Ohio':
      return ['Columbus', 'Cleveland', 'Cincinnati', 'Toledo', 'Akron'];
    case 'Oklahoma':
      return ['Oklahoma City', 'Tulsa', 'Norman', 'Broken Arrow', 'Lawton'];
    case 'Oregon':
      return ['Portland', 'Salem', 'Eugene', 'Gresham', 'Hillsboro'];
    case 'Pensilvania':
      return ['Philadelphia', 'Pittsburgh', 'Allentown', 'Erie', 'Reading'];
    case 'Rhode Island':
      return [
        'Providence',
        'Cranston',
        'Warwick',
        'Pawtucket',
        'East Providence'
      ];
    case 'Tennessee':
      return [
        'Nashville',
        'Memphis',
        'Knoxville',
        'Chattanooga',
        'Clarksville'
      ];
    case 'Texas':
      return ['Houston', 'San Antonio', 'Dallas', 'Austin', 'Fort Worth'];
    case 'Utah':
      return [
        'Salt Lake City',
        'West Valley City',
        'Provo',
        'West Jordan',
        'Orem'
      ];
    case 'Vermont':
      return [
        'Burlington',
        'Essex',
        'Colchester',
        'South Burlington',
        'Bennington'
      ];
    case 'Virginia':
      return [
        'Virginia Beach',
        'Norfolk',
        'Chesapeake',
        'Richmond',
        'Newport News'
      ];
    case 'West Virginia':
      return [
        'Charleston',
        'Huntington',
        'Parkersburg',
        'Morgantown',
        'Wheeling'
      ];
    case 'Washington':
      return ['Seattle', 'Spokane', 'Tacoma', 'Vancouver', 'Bellevue'];
    case 'Wisconsin':
      return ['Milwaukee', 'Madison', 'Green Bay', 'Kenosha', 'Racine'];
    case 'Wyoming':
      return ['Cheyenne', 'Casper', 'Laramie', 'Gillette', 'Rock Springs'];
    default:
      return [];
  }
}

String tipConverter(
  String value,
  String tipPercentage,
) {
  double? numericValue = double.tryParse(value);
  double? numericTipPercentage = double.tryParse(tipPercentage);

  // If either value is null (invalid), return 0
  if (numericValue == null || numericTipPercentage == null) {
    return '0';
  }

  // Calculate the tip amount
  double tipAmount = numericValue * (numericTipPercentage / 100);

  // Return the result as a string
  return tipAmount.toStringAsFixed(2);
}

List<int> stringToArrayInteger(String listTipsString) {
  // Ensure the input is treated as a String and sanitized properly
  String sanitizedString =
      listTipsString.replaceAll('[', '').replaceAll(']', '');

  // Split the string into a list of individual elements
  List<String> listTips = sanitizedString.split(',');

  // Convert each string element into an integer
  List<int> newList = listTips.map((str) {
    try {
      return int.parse(str.trim()); // Trim any extra spaces
    } catch (e) {
      return 0; // Return 0 for invalid numbers
    }
  }).toList();

  // Return the processed list
  return newList;
}

String arrayToString(List<String> listNotes) {
  // array to array string
  List<String> formattedNotes =
      listNotes.map((note) => '{message: $note; note: $note;}').toList();
  return formattedNotes.toString();
}

List<int> stringArrayToArrayInteger(List<String> listTips) {
  List<int> newList = [];
  newList = listTips.map((str) {
    try {
      return int.parse(str);
    } catch (e) {
      return 0;
    }
  }).toList();

  return newList;
}

List<String> stringArrayToListString(String stringArray) {
  String jsonString = stringArray
      .replaceAllMapped(RegExp(r'(\w+):'), (match) => '"${match[1]}":')
      .replaceAllMapped(
          RegExp(r'([a-zA-Z0-9\s]+);'), (match) => '"${match[1]}"');

  try {
    List<dynamic> parsedList = jsonDecode(jsonString);

    List<String> stringList =
        parsedList.map((item) => jsonEncode(item)).toList();

    return stringList;
  } catch (e) {
    print("Error parsing JSON: $e");
    return []; // Return an empty list or handle the error as needed
  }
}

int stripeAmountConverter(
  String? amountValue,
  String? tip,
) {
  // Initialize total amount
  int totalAmount = 0;

  // Check if amountValue is not null and can be parsed to an integer
  if (amountValue != null && amountValue.isNotEmpty) {
    final parsedAmount = int.tryParse(amountValue);
    if (parsedAmount != null) {
      totalAmount += parsedAmount;
    }
  }

  // Check if tip is not null and can be parsed to an integer
  if (tip != null && tip.isNotEmpty) {
    final parsedTip = int.tryParse(tip);
    if (parsedTip != null) {
      totalAmount += parsedTip;
    }
  }

  // Return the total amount divided by 100
  return totalAmount * 100; // Using integer division
}

double sumStrings(
  String str1,
  String str2,
) {
  // sum strings arguments
  // Convert the strings to double, using double.tryParse to handle invalid inputs gracefully
  double num1 = double.tryParse(str1) ?? 0.0; // Default to 0.0 if parsing fails
  double num2 = double.tryParse(str2) ?? 0.0; // Default to 0.0 if parsing fails

  // Return the sum of the two numbers
  return num1 + num2;
}

String stringToImagePath(String imagePathUrl) {
  // string url to imagepath
  // Convert a URL string to an image path
  return Uri.parse(imagePathUrl).toString();
}

bool validateResponseProfile(
  String? jsonResponse,
  String? jsonCondition,
) {
  // validate if jsonResponse has 'Profile sent' in their first characters return true or false
  if (jsonResponse != null && jsonCondition != null) {
    return jsonResponse.startsWith(jsonCondition);
  }
  return false;
}

List<String> arrayStringtoStringList(String arrayString) {
  if (arrayString.isEmpty) {
    return [];
  }

  // Remover los corchetes y dividir los elementos del string
  final sanitizedString = arrayString.substring(1, arrayString.length - 1);
  final elements = sanitizedString.split(',').map((e) {
    // Remover comillas y espacios alrededor de cada elemento
    return e.trim().replaceAll('"', '').replaceAll("'", '');
  }).toList();

  return elements;
}

String? last5charactersFromAddressString(String addressString) {
  // return last 5 characters of strings if they are valid numbers, if character not valid return null
  double validZipCode =
      double.tryParse(addressString.substring(addressString.length - 5)) ?? 0;
  if (validZipCode != 0) {
    return addressString.length > 5
        ? addressString.substring(addressString.length - 5)
        : addressString;
  }
  return null;
}

String sortbyargs(
  String jsonStringInput,
  String arrayKey,
  String sortProperty,
  bool isAscending,
) {
  int compareProperties(dynamic a, dynamic b, String property, bool ascending) {
    if (a is! Map || b is! Map) {
      return 0;
    }

    final valA = a[property];
    final valB = b[property];

    if (valA == null && valB == null) return 0;
    if (valA == null) return ascending ? -1 : 1;
    if (valB == null) return ascending ? 1 : -1;

    int comparisonResult;

    if (valA is num && valB is num) {
      comparisonResult = (valA as num).compareTo(valB as num);
    } else {
      num? numA =
          (valA is num) ? valA : (valA is String ? num.tryParse(valA) : null);

      num? numB =
          (valB is num) ? valB : (valB is String ? num.tryParse(valB) : null);

      if (numA != null && numB != null) {
        comparisonResult = numA.compareTo(numB);
      } else {
        if (valA is Comparable && valB is Comparable) {
          try {
            comparisonResult = valA.compareTo(valB);
          } catch (e) {
            // In FF, console.print might not be visible, rely on error returns
            // print('Error during fallback comparison for property "$property": $valA (${valA.runtimeType}) vs $valB (${valB.runtimeType}). Error: $e. Treating as equal.');
            comparisonResult = 0;
          }
        } else {
          // print('Warning: Values for property "$property" are not numerically sortable and not mutually Comparable: $valA (${valA.runtimeType}), $valB (${valB.runtimeType}). Treating as equal.');
          comparisonResult = 0;
        }
      }
    }
    return ascending ? comparisonResult : -comparisonResult;
  }

  try {
    final decodedJson = jsonDecode(jsonStringInput);
    List<dynamic>? listToProcess;
    if (decodedJson is Map<String, dynamic>) {
      if (decodedJson.containsKey(arrayKey)) {
        final dynamic valueAtKey = decodedJson[arrayKey];
        if (valueAtKey is List) {
          listToProcess = List<dynamic>.from(valueAtKey); // Create mutable copy
        } else if (valueAtKey == null) {
          // Key found, value is null. listToProcess remains null, allowing fallback.
          // print('Info: Key "$arrayKey" points to null. Will check if entire JSON is an array.');
        } else {
          // Key found, but value is not a List and not null. This is an error for this key.
          // print('Error: Value for key "$arrayKey" is type ${valueAtKey.runtimeType}, not a List or null.');
          return '{"error": "Value for key \'$arrayKey\' is not an array or null"}';
        }
      } else {
        // Key not found in map. listToProcess remains null, allowing fallback.
        // print('Info: Key "$arrayKey" not found in JSON object. Will check if entire JSON is an array.');
      }
    }

    if (listToProcess == null) {
      if (decodedJson is List) {
        listToProcess = List<dynamic>.from(decodedJson); // Create mutable copy
      }
    }
    if (listToProcess == null) {
      return '{"error": "No valid array found to sort with the given parameters"}';
    }
    if (listToProcess.isEmpty) {
      return '[]';
    }

    listToProcess.sort((a, b) {
      return compareProperties(a, b, sortProperty, isAscending);
    });

    return jsonEncode(listToProcess);
  } catch (e) {
    return '{"error": "An unexpected error occurred: ${e.toString().replaceAll('"', '\\"')}"}';
  }
}
