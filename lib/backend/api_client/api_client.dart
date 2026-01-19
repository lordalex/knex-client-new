import 'dart:convert';
import 'package:http/http.dart' as http;
import '/backend/api_client/models/index.dart';
import '/auth/firebase_auth/auth_util.dart';

class ApiClient {
  ApiClient({this.baseUrl = 'https://client.knex-app.xyz/api'});

  final String baseUrl;

  Future<dynamic> _callApi(
    String path, {
    String method = 'POST',
    Map<String, dynamic>? body,
    bool isAuthRequired = true,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = {
      'Content-Type': 'application/json',
    };

    if (isAuthRequired) {
      headers['Authorization'] = 'Bearer $currentJwtToken';
    }

    final requestBody = json.encode({
      if (isAuthRequired) 'idToken': currentJwtToken,
      'data': body,
    });

    print("📤 [ApiClient] $method $url");
    print("📤 [ApiClient] Headers: $headers");
    print(
        "📤 [ApiClient] Body: ${body.toString().length > 200 ? body.toString().substring(0, 200) + '...' : body}");

    http.Response response;
    try {
      if (method == 'POST') {
        response = await http.post(url, headers: headers, body: requestBody);
      } else {
        // Handle other methods if needed
        throw UnimplementedError('HTTP method $method not implemented.');
      }
    } catch (e) {
      print("❌ [ApiClient] Network error: $e");
      rethrow;
    }

    print("📥 [ApiClient] Response Status: ${response.statusCode}");
    print(
        "📥 [ApiClient] Response Body: ${response.body.length > 500 ? response.body.substring(0, 500) + '...' : response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to call API: ${response.statusCode} ${response.body}');
    }
  }

  Future<CrudResult> createUserClient(UserClientProfile data) async {
    final response = await _callApi(
      '/createUserClient',
      body: data.toMap(),
    );
    return CrudResult.fromMap(response);
  }

  Future<UserClientProfile> getUserClient(String id) async {
    final response = await _callApi(
      '/getUserClient',
      body: {'id': id},
    );
    return UserClientProfile.fromMap(response);
  }

  Future<CrudResult> updateUserClient(UserClientProfile data) async {
    final response = await _callApi(
      '/updateUserClient',
      body: data.toMap(),
    );
    return CrudResult.fromMap(response);
  }

  Future<List<UserClientProfile>> searchUserClient(
      Map<String, dynamic> searchCriteria) async {
    final response = await _callApi(
      '/searchUserClient',
      body: {'searchCriteria': searchCriteria},
    );
    return (response as List).map((data) {
      final insData = json.decode(data['insData']);
      insData['id'] = data['id'];
      return UserClientProfile.fromMap(insData);
    }).toList();
  }

  Future<CrudResult> deleteUserClient(String id) async {
    final response = await _callApi(
      '/deleteUserClient',
      body: {'id': id},
    );
    return CrudResult.fromMap(response);
  }

  Future<List<UserClientProfile>> listUserClients() async {
    final response = await _callApi(
      '/listUserClients',
      body: {},
    );
    return (response as List)
        .map((data) => UserClientProfile.fromMap(data))
        .toList();
  }

  Future<CrudResult> createVehicle(VehicleCreation data) async {
    final response = await _callApi(
      '/createVehicle',
      body: data.toMap(),
    );
    return CrudResult.fromMap(response);
  }

  Future<List<Vehicle>> listVehicles() async {
    final response = await _callApi(
      '/listVehicles',
      body: {},
    );
    return (response as List).map((data) => Vehicle.fromMap(data)).toList();
  }

  Future<Vehicle> getVehicle(String id) async {
    final response = await _callApi(
      '/getVehicle',
      body: {'id': id},
    );
    return Vehicle.fromMap(response);
  }

  Future<CrudResult> updateVehicle(Vehicle data) async {
    final response = await _callApi(
      '/updateVehicle',
      body: data.toMap(),
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> deleteVehicle(String id) async {
    final response = await _callApi(
      '/deleteVehicle',
      body: {'id': id},
    );
    return CrudResult.fromMap(response);
  }

  Future<ProvisionalTicket> createProvisionalTicket(
      ProvisionalTicket data) async {
    final response = await _callApi(
      '/createProvisionalTicket',
      body: data.toMap(),
      isAuthRequired: false,
    );
    return ProvisionalTicket.fromMap(response);
  }

  Future<CrudResult> linkUserClientToTicketByProvisionalPIN(String pin) async {
    final response = await _callApi(
      '/linkUserClientToTicketByProvisionalPIN',
      body: {'pin': pin},
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> setToDepartureCasual(String pin) async {
    final response = await _callApi(
      '/setToDepartureCasual',
      body: {'pin': pin},
      isAuthRequired: false,
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> setToDeparture(String ticketId) async {
    final response = await _callApi(
      '/setToDeparture',
      body: {'ticketId': ticketId},
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> setToCancelForClient(String ticketId) async {
    final response = await _callApi(
      '/setToCancelForClient',
      body: {'ticketId': ticketId},
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> setTicketTip(String ticketId, double tip) async {
    final response = await _callApi(
      '/setTicketTip',
      body: {'ticketId': ticketId, 'tip': tip},
    );
    return CrudResult.fromMap(response);
  }

  Future<CrudResult> setTicketStatus(String ticketId, String status) async {
    final response = await _callApi(
      '/setTicketStatus',
      body: {'ticketId': ticketId, 'status': status},
    );
    return CrudResult.fromMap(response);
  }

  Future<List<Ticket>> getTicketList() async {
    final response = await _callApi(
      '/getTicketList',
      body: {},
    );
    return (response as List).map((data) => Ticket.fromMap(data)).toList();
  }

  Future<Ticket?> getLatestTicket() async {
    print("🔍 [ApiClient] getLatestTicket called");
    try {
      final response = await _callApi(
        '/getLatestTicket',
        body: {},
      );
      print("✅ [ApiClient] getLatestTicket response received");
      final ticket = Ticket.fromMap(response);
      print(
          "✅ [ApiClient] Ticket parsed: status=${ticket.status}, id=${ticket.id}");
      return ticket;
    } catch (e) {
      print("⚠️ [ApiClient] getLatestTicket error: $e");
      if (e.toString().contains('404')) {
        print("ℹ️ [ApiClient] 404 - No ticket found, returning null");
        return null;
      }
      rethrow;
    }
  }

  Future<Ticket> getTicketByPIN(String pin) async {
    final response = await _callApi(
      '/getTicketByPIN',
      body: {'pin': pin},
    );
    return Ticket.fromMap(response);
  }

  Future<List<Location>> getLocations() async {
    final response = await _callApi(
      '/getLocations',
      body: {},
    );
    return (response as List).map((data) => Location.fromMap(data)).toList();
  }

  Future<CrudResult> createTicket(Ticket data) async {
    final response = await _callApi(
      '/createTicket',
      body: data.toMap(),
    );
    return CrudResult.fromMap(response);
  }
}
