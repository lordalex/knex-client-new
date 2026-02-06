// Material import removed as unused
// Provider/auth_util removed as unused (unless needed for checking token, but logic passes them in)
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart'; // For Widget imports like ProfileCreateWidget, TicketWidget
import 'package:http/http.dart' as http; // Basic http for schema fetching
import '/backend/api_client/api_client.dart';
import '/demo/demo_config.dart';

class FlowManager {
  // Singleton pattern for easy access if needed, though static methods might suffice.
  static final FlowManager _instance = FlowManager._internal();

  factory FlowManager() {
    return _instance;
  }

  FlowManager._internal();

  // Cache for the schema to avoid re-fetching constantly
  static Map<String, dynamic>? _cachedSchema;
  static const String _schemaUrl =
      'https://storage.googleapis.com/knex-attendant-25.firebasestorage.app/client_openapi.json';

  /// Fetches and caches the OpenAPI schema
  static Future<Map<String, dynamic>?> fetchSchema() async {
    if (_cachedSchema != null) return _cachedSchema;

    if (DemoConfig.isDemo) {
      _cachedSchema = {
        'components': {
          'schemas': {
            'UserClientProfile': {
              'required': ['firstName', 'lastName', 'phoneNumber', 'email'],
              'properties': {
                'firstName': {'type': 'string'},
                'lastName': {'type': 'string'},
                'phoneNumber': {'type': 'string'},
                'email': {'type': 'string'},
              },
            },
          },
        },
      };
      print('[FlowManager] Demo mode: using hardcoded schema');
      return _cachedSchema;
    }

    try {
      print("🔍 [FlowManager] Fetching OpenAPI schema from defined URL...");
      final response = await http.get(Uri.parse(_schemaUrl));

      if (response.statusCode == 200) {
        _cachedSchema = jsonDecode(response.body);
        print("✅ [FlowManager] Schema fetched and cached successfully.");
        return _cachedSchema;
      } else {
        print(
            "❌ [FlowManager] Failed to fetch schema. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ [FlowManager] Error fetching schema: $e");
      return null;
    }
  }

  /// Extracts required fields from the UserClientProfile definition in the schema
  /// Returns a List of required field names (e.g., ['firstName', 'lastName', 'phoneNumber'])
  static List<String> getRequiredFieldsFromSchema(
      Map<String, dynamic>? schema) {
    if (schema == null) return [];

    try {
      // Navigate to components -> schemas -> UserClientProfile -> required
      final components = schema['components'];
      if (components == null) return [];

      final schemas = components['schemas'];
      if (schemas == null) return [];

      // We look for 'UserClientProfile' as per the downloaded schema analysis
      // Fallback to 'UserClient' if profile not found (just in case)
      final userProfile = schemas['UserClientProfile'] ?? schemas['UserClient'];
      if (userProfile == null) return [];

      final requiredList = userProfile['required'];
      if (requiredList is List) {
        return requiredList.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print("⚠️ [FlowManager] Error parsing required fields from schema: $e");
    }
    return [];
  }

  /// Validates profile data against the dynamic schema
  /// Returns true if valid, false if missing required fields
  static Future<bool> validateProfileAgainstSchema(
      Map<String, dynamic> profileData) async {
    print("🔍 [FlowManager] Profile data keys: ${profileData.keys.toList()}");
    print("🔍 [FlowManager] Profile data: $profileData");

    await fetchSchema();
    final requiredFields = getRequiredFieldsFromSchema(_cachedSchema);

    if (requiredFields.isEmpty) {
      print(
          "⚠️ [FlowManager] No required fields found in schema. Defaulting to legacy check.");
      // Fallback to minimal check if schema fails
      return checkProfileCompletenessLegacy(profileData) == null;
    }

    print(
        "🔍 [FlowManager] Validating against schema required fields: $requiredFields");

    // Normalize profile keys to lower case for comparison if needed,
    // but the schema usually defines strict casing (e.g. firstName).
    // Our fetching logic tries to find keys case-insensitively,
    // so we should check availability using our helper.

    // Helper to check if a key exists in profileData (case-insensitive) and is not empty
    bool hasField(String reqKey) {
      // Try exact match first
      if (profileData.containsKey(reqKey) &&
          profileData[reqKey] != null &&
          profileData[reqKey].toString().isNotEmpty) {
        return true;
      }

      // Try lowercase match
      final lowerReq = reqKey.toLowerCase();
      for (final key in profileData.keys) {
        if (key.toLowerCase() == lowerReq) {
          final val = profileData[key];
          return val != null && val.toString().isNotEmpty;
        }
      }

      // Special mappings for specific known deviations (legacy fallback)
      if (lowerReq == 'firstname') {
        // check firstName, first_name, etc.
        return (profileData['firstName']?.toString().isNotEmpty ?? false) ||
            (profileData['firstname']?.toString().isNotEmpty ?? false);
      }
      if (lowerReq == 'lastname') {
        return (profileData['lastName']?.toString().isNotEmpty ?? false) ||
            (profileData['lastname']?.toString().isNotEmpty ?? false);
      }
      if (lowerReq == 'phonenumber' || lowerReq == 'phone') {
        return (profileData['phoneNumber']?.toString().isNotEmpty ?? false) ||
            (profileData['phone']?.toString().isNotEmpty ?? false);
      }
      if (lowerReq == 'postalcode' || lowerReq == 'zipcode') {
        return (profileData['postalCode']?.toString().isNotEmpty ?? false) ||
            (profileData['zipCode']?.toString().isNotEmpty ?? false);
      }

      return false;
    }

    for (final field in requiredFields) {
      if (!hasField(field)) {
        print("❌ [FlowManager] Missing required field: $field");
        return false;
      }
    }

    return true;
  }

  /// Legacy helper for fallback
  static String? checkProfileCompletenessLegacy(
      Map<String, dynamic> profileData) {
    // ... original logic ...
    // Re-implementing simplified version here or call existing logic if we kept it?
    // We are REPLACING the old checkProfileCompleteness, so let's move the old logic here as fallback.

    // Helper to extract safely with fallback keys
    String getString(List<String> keys) {
      for (final key in keys) {
        if (profileData.containsKey(key)) {
          final val = profileData[key];
          if (val != null && val.toString().isNotEmpty) {
            return val.toString();
          }
        }
      }
      return '';
    }

    final firstname = getString(['firstName', 'firstname']);
    final lastname = getString(['lastName', 'lastname']);
    final phone = getString(['phoneNumber', 'phone']);

    bool isComplete = firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        phone.isNotEmpty;

    if (!isComplete) return ProfileCreateWidget.routeName;
    return null;
  }

  /// Extracts all properties from the UserClientProfile schema
  /// Returns a Map of property names to their definitions (or just empty map if not found)
  static Map<String, dynamic> getSchemaProperties() {
    final schema = _cachedSchema;
    if (schema == null) return {};

    try {
      final components = schema['components'];
      if (components == null) return {};

      final schemas = components['schemas'];
      if (schemas == null) return {};

      final userProfile = schemas['UserClientProfile'] ?? schemas['UserClient'];
      if (userProfile == null) return {};

      final properties = userProfile['properties'];
      if (properties is Map<String, dynamic>) {
        return properties;
      }
    } catch (e) {
      print("⚠️ [FlowManager] Error parsing properties from schema: $e");
    }
    return {};
  }

  /// Centralized check for profile completion
  /// Returns NULL if complete, or the routeName to redirect to if incomplete.
  static Future<String?> checkProfileCompleteness(
      Map<String, dynamic> profileData) async {
    print("🔍 [FlowManager] Checking profile completeness (Dynamic)...");

    // Use dynamic validation
    bool isValid = await validateProfileAgainstSchema(profileData);

    if (!isValid) {
      print("⚠️ [FlowManager] Profile is incomplete (Schema Mismatch).");
      return ProfileCreateWidget.routeName;
    }

    print("✅ [FlowManager] Profile is complete.");
    return null; // No redirect needed
  }

  /// Fetches profile data from backend and parses it.
  /// Returns the parsed JSON map or throws error.
  static Future<Map<String, dynamic>> fetchProfileData(
      String jwtToken, String email) async {
    print("🔍 [FlowManager] Fetching profile data for $email");

    try {
      final apiClient = ApiClient();
      final profiles = await apiClient.searchUserClient({'email': email});

      if (profiles.isEmpty) {
        print("⚠️ [FlowManager] Profile not found or empty response.");
        return {};
      }

      // Return the first profile as a Map
      // We explicitly trust ApiClient parsing
      return profiles.first.toMap();
    } catch (e) {
      if (e.toString().contains('401')) {
        throw Exception('401 Unauthorized');
      }
      print("❌ [FlowManager] Fetch/Parse Error: $e");
      // Return bare minimum to avoid crashes, but likely incomplete
      return {};
    }
  }

  /// Checks for active tickets
  /// Returns routeName to redirect to if active ticket exists, else null.
  static Future<String?> checkActiveTicket(
      String jwtToken, String email) async {
    print("🔍 [FlowManager] Checking active tickets...");

    try {
      final apiClient = ApiClient();
      final ticket = await apiClient.getLatestTicket();

      if (ticket == null) {
        print("ℹ️ [FlowManager] No active ticket found (null response)");
        return null;
      }

      print("🔍 [FlowManager] Ticket status: '${ticket.status}'");

      if (ticket.status.isNotEmpty &&
          ticket.status != 'Cancelled' &&
          ticket.status != 'Completed') {
        print(
            "⚠️ [FlowManager] Active ticket found (status: ${ticket.status}). Redirecting to TicketWidget.");
        return TicketWidget.routeName;
      }

      return null;
    } catch (e) {
      print("⚠️ [FlowManager] Network error checking tickets: $e");
      return null;
    }
  }

  /// Master method to decide where the user should go.
  /// Use this in Splash, Login, or explicit "Refresh" actions.
  ///
  /// Returns the Route Name to go to.
  /// Default is HomePageWidget.routeName if everything is fine.
  static Future<String> determineInitialRoute(
      String jwtToken, String email) async {
    try {
      final profileMap = await fetchProfileData(jwtToken, email);

      // 1. Check Profile
      String? profileRedirect = await checkProfileCompleteness(profileMap);
      if (profileRedirect != null) return profileRedirect;

      // 2. Check Ticket
      String? ticketRedirect = await checkActiveTicket(jwtToken, email);
      if (ticketRedirect != null) return ticketRedirect;

      // 3. All clear
      return HomePageWidget.routeName;
    } catch (e) {
      if (e.toString().contains('401')) {
        return LoginSignUpWidget.routeName;
      }
      print("❌ [FlowManager] Error determining route: $e");
      return HomePageWidget
          .routeName; // Fallback to Home, let it handle error state
    }
  }
}
