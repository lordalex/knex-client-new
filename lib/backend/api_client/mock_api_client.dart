part of 'api_client.dart';

/// A Ticket subclass that includes extra fields (site, created_at, etc.)
/// so the TicketWidget can read them via getkeyfromjsonstring.
class _DemoTicket extends Ticket {
  _DemoTicket({
    super.id,
    super.ticketNumber,
    required super.userClientId,
    required super.vehicleId,
    required super.status,
    required super.locationId,
    super.notes,
    super.pin,
    required this.site,
    required this.createdAt,
  });

  final Map<String, dynamic> site;
  final String createdAt;

  @override
  Map<String, dynamic> toMap() {
    // Build manually to avoid .withoutNulls String cast issue with nested Map
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (ticketNumber != null) map['ticket_number'] = ticketNumber;
    map['user_client_id'] = userClientId;
    map['vehicle_id'] = vehicleId;
    map['status'] = status;
    map['location_id'] = locationId;
    if (notes != null) map['notes'] = notes;
    if (pin != null) map['pin'] = pin;
    map['site'] = site;
    map['created_at'] = createdAt;
    map['lockerSpace'] = 'L-12';
    map['parkingSpace'] = 'P-7';
    return map;
  }
}

class MockApiClient extends ApiClient {
  MockApiClient._() : super._real();

  // --- In-memory stores (session-persistent via statics) ---
  static final List<UserClientProfile> _profiles = [
    UserClientProfile(
      id: 'demo_profile_001',
      uid: 'demo_uid_001',
      email: 'demo@knex-app.xyz',
      firstName: 'Alex',
      lastName: 'Sunshine',
      phoneNumber: '(305) 555-0123',
      photo: null,
      createdAt: DateTime(2025, 1, 15),
      updatedAt: DateTime(2025, 6, 1),
    ),
  ];

  static final List<Vehicle> _vehicles = [];

  static final List<Ticket> _tickets = [];

  static int _vehicleCounter = 0;
  static int _ticketCounter = 0;

  /// Tracks when the last ticket was created for auto-advancing status.
  static DateTime? _lastTicketCreatedAt;

  /// Tracks when departure was requested for auto-advancing departure statuses.
  static DateTime? _departureRequestedAt;

  static final List<Location> _locations = [
    Location.fromMap({
      'id': 'loc_001',
      'name': "Truluck's Fort Lauderdale",
      'address': '2584 E Sunrise Blvd, Fort Lauderdale, FL 33304',
      'coordinates_latitude': 26.1367,
      'coordinates_longitude': -80.1066,
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      'bio': 'Upscale seafood restaurant known for stone crab and ocean-to-table dining. Valet available for all guests.',
      'Company': {'name': 'KNEX Valet'},
      'currency': 'USD',
      'value': 15.00,
      'photos': [
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
        'https://images.unsplash.com/photo-1550966871-3ed3cdb51f3a?w=800',
      ],
      'notes': 'Valet stand is at the main entrance. Please have your ticket ready.',
    }),
    Location.fromMap({
      'id': 'loc_002',
      'name': 'The Breakers Palm Beach',
      'address': '1 S County Rd, Palm Beach, FL 33480',
      'coordinates_latitude': 26.7153,
      'coordinates_longitude': -80.0364,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      'bio': 'Legendary oceanfront resort offering world-class amenities since 1896. Complimentary valet for hotel guests.',
      'Company': {'name': 'KNEX Valet'},
      'currency': 'USD',
      'value': 20.00,
      'photos': [
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
        'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
      ],
      'notes': 'Pull up to the main porte-cochere. Valet attendants will greet you.',
    }),
    Location.fromMap({
      'id': 'loc_003',
      'name': 'Brickell City Centre',
      'address': '701 S Miami Ave, Miami, FL 33131',
      'coordinates_latitude': 25.7650,
      'coordinates_longitude': -80.1936,
      'image': 'https://images.unsplash.com/photo-1533929736458-ca588d08c8be?w=800',
      'bio': 'Premier mixed-use destination in the heart of Brickell. Valet parking available at the main retail entrance.',
      'Company': {'name': 'KNEX Valet'},
      'currency': 'USD',
      'value': 12.00,
      'photos': [
        'https://images.unsplash.com/photo-1533929736458-ca588d08c8be?w=800',
        'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800',
      ],
      'notes': 'Valet available at Level 1 entrance near the climate ribbon.',
    }),
  ];

  static CrudResult _successResult([dynamic data]) => CrudResult.fromMap({
        'status': {'status': 'VALID', 'result': 'CREATED', 'message': null},
        'data': data,
      });

  // --- UserClient methods ---

  @override
  Future<CrudResult> createUserClient(UserClientProfile data) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] createUserClient');
    _profiles.add(data);
    return _successResult();
  }

  @override
  Future<UserClientProfile> getUserClient(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] getUserClient($id)');
    return _profiles.firstWhere(
      (p) => p.id == id,
      orElse: () => _profiles.first,
    );
  }

  @override
  Future<CrudResult> updateUserClient(UserClientProfile data) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] updateUserClient');
    final idx = _profiles.indexWhere((p) => p.id == data.id || p.email == data.email);
    if (idx >= 0) {
      _profiles[idx] = data;
    } else {
      _profiles.add(data);
    }
    return _successResult();
  }

  @override
  Future<List<UserClientProfile>> searchUserClient(
      Map<String, dynamic> searchCriteria) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] searchUserClient($searchCriteria)');
    if (searchCriteria.containsKey('email')) {
      final email = searchCriteria['email'];
      final matches = _profiles.where((p) => p.email == email).toList();
      return matches.isNotEmpty ? matches : _profiles;
    }
    return _profiles;
  }

  @override
  Future<CrudResult> deleteUserClient(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] deleteUserClient($id)');
    _profiles.removeWhere((p) => p.id == id);
    return _successResult();
  }

  @override
  Future<List<UserClientProfile>> listUserClients() async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] listUserClients');
    return List.unmodifiable(_profiles);
  }

  // --- Vehicle methods ---

  @override
  Future<CrudResult> createVehicle(VehicleCreation data) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] createVehicle');
    _vehicleCounter++;
    final vehicle = Vehicle(
      id: 'demo_vehicle_$_vehicleCounter',
      userClientId: 'demo_uid_001',
      vehicleMake: data.vehicleMake,
      vehicleModel: data.vehicleModel,
      vehicleYear: data.vehicleYear,
      licensePlate: data.licensePlate,
      color: data.color,
      vin: data.vin,
    );
    _vehicles.add(vehicle);
    return _successResult({'id': vehicle.id});
  }

  @override
  Future<List<Vehicle>> listVehicles() async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] listVehicles');
    return List.unmodifiable(_vehicles);
  }

  @override
  Future<Vehicle> getVehicle(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] getVehicle($id)');
    return _vehicles.firstWhere(
      (v) => v.id == id,
      orElse: () => throw Exception('Vehicle not found: $id'),
    );
  }

  @override
  Future<CrudResult> updateVehicle(Vehicle data) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] updateVehicle');
    final idx = _vehicles.indexWhere((v) => v.id == data.id);
    if (idx >= 0) _vehicles[idx] = data;
    return _successResult();
  }

  @override
  Future<CrudResult> deleteVehicle(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    print('[MockApiClient] deleteVehicle($id)');
    _vehicles.removeWhere((v) => v.id == id);
    return _successResult();
  }

  // --- Ticket methods ---

  @override
  Future<ProvisionalTicket> createProvisionalTicket(
      ProvisionalTicket data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('[MockApiClient] createProvisionalTicket');
    return ProvisionalTicket(
      id: 'demo_prov_ticket_001',
      pin: '8842',
      locationId: data.locationId,
      vehicle: data.vehicle,
    );
  }

  @override
  Future<CrudResult> linkUserClientToTicketByProvisionalPIN(String pin) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] linkUserClientToTicketByProvisionalPIN($pin)');
    return _successResult();
  }

  @override
  Future<CrudResult> setToDepartureCasual(String pin) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] setToDepartureCasual($pin)');
    return _successResult();
  }

  /// Helper to clone a ticket with a new status, preserving _DemoTicket fields.
  static Ticket _withStatus(Ticket old, String newStatus) {
    if (old is _DemoTicket) {
      return _DemoTicket(
        id: old.id,
        ticketNumber: old.ticketNumber,
        userClientId: old.userClientId,
        vehicleId: old.vehicleId,
        status: newStatus,
        locationId: old.locationId,
        notes: old.notes,
        pin: old.pin,
        site: old.site,
        createdAt: old.createdAt,
      );
    }
    return Ticket(
      id: old.id,
      ticketNumber: old.ticketNumber,
      userClientId: old.userClientId,
      vehicleId: old.vehicleId,
      status: newStatus,
      locationId: old.locationId,
      notes: old.notes,
      pin: old.pin,
    );
  }

  @override
  Future<CrudResult> setToDeparture(String ticketId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] setToDeparture($ticketId)');
    final idx = _tickets.indexWhere((t) => t.id == ticketId);
    if (idx >= 0) _tickets[idx] = _withStatus(_tickets[idx], 'Departure');
    _departureRequestedAt = DateTime.now();
    return CrudResult.fromMap({
      'status': {'status': 'UPDATED', 'result': 'UPDATED', 'message': null},
      'data': null,
    });
  }

  @override
  Future<CrudResult> setToCancelForClient(String ticketId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] setToCancelForClient($ticketId)');
    final idx = _tickets.indexWhere((t) => t.id == ticketId);
    if (idx >= 0) _tickets[idx] = _withStatus(_tickets[idx], 'Cancelled');
    return _successResult();
  }

  @override
  Future<CrudResult> setTicketTip(String ticketId, double tip) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] setTicketTip($ticketId, $tip)');
    return _successResult();
  }

  @override
  Future<CrudResult> setTicketStatus(String ticketId, String status) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] setTicketStatus($ticketId, $status)');
    final idx = _tickets.indexWhere((t) => t.id == ticketId);
    if (idx >= 0) _tickets[idx] = _withStatus(_tickets[idx], status);
    return _successResult();
  }

  @override
  Future<List<Ticket>> getTicketList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] getTicketList');
    // Auto-advance active tickets before returning the list
    for (var i = 0; i < _tickets.length; i++) {
      final t = _tickets[i];
      if (t.status != 'Cancelled' && t.status != 'Completed') {
        _autoAdvanceStatus(t);
      }
    }
    return List.unmodifiable(_tickets);
  }

  /// Auto-advances the active ticket status based on elapsed time.
  /// Arrival phase (from creation):  0-15s Parked → 15s+ Processing-Arrival
  /// Departure phase (from request): sequential: Departure → Processing-Departure → Completed
  /// Each step advances ONE status per poll to ensure the UI sees every transition.
  static Ticket _autoAdvanceStatus(Ticket ticket) {
    // Departure phase takes priority (user tapped "Request Pick Up")
    if (_departureRequestedAt != null) {
      final elapsed =
          DateTime.now().difference(_departureRequestedAt!).inSeconds;
      // Advance one step at a time to ensure each status is seen by the UI
      String? newStatus;
      if (ticket.status == 'Departure' && elapsed >= 10) {
        newStatus = 'Processing-Departure';
      } else if (ticket.status == 'Processing-Departure' && elapsed >= 25) {
        newStatus = 'Completed';
      } else if (ticket.status != 'Departure' &&
          ticket.status != 'Processing-Departure' &&
          ticket.status != 'Completed') {
        // If somehow still on an earlier status (e.g. Processing-Arrival), jump to Departure first
        newStatus = 'Departure';
      }
      if (newStatus != null && ticket.status != newStatus) {
        print('[MockApiClient] Auto-advancing (departure): '
            '${ticket.status} → $newStatus (${elapsed}s since departure request)');
        final idx = _tickets.indexOf(ticket);
        if (idx >= 0) {
          _tickets[idx] = _withStatus(ticket, newStatus);
          return _tickets[idx];
        }
      }
      return ticket;
    }

    // Arrival phase (auto-advance from Parked)
    if (_lastTicketCreatedAt != null && ticket.status == 'Parked') {
      final elapsed =
          DateTime.now().difference(_lastTicketCreatedAt!).inSeconds;
      if (elapsed >= 15) {
        print('[MockApiClient] Auto-advancing (arrival): '
            '${ticket.status} → Processing-Arrival (${elapsed}s since creation)');
        final idx = _tickets.indexOf(ticket);
        if (idx >= 0) {
          _tickets[idx] = _withStatus(ticket, 'Processing-Arrival');
          return _tickets[idx];
        }
      }
    }

    return ticket;
  }

  @override
  Future<Ticket?> getLatestTicket() async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] getLatestTicket');
    if (_tickets.isEmpty) return null;
    final active = _tickets.where(
      (t) => t.status != 'Cancelled' && t.status != 'Completed',
    );
    if (active.isEmpty) return null;
    return _autoAdvanceStatus(active.last);
  }

  @override
  Future<Ticket> getTicketByPIN(String pin) async {
    await Future.delayed(const Duration(milliseconds: 200));
    print('[MockApiClient] getTicketByPIN($pin)');
    return _tickets.firstWhere(
      (t) => t.pin == pin,
      orElse: () => throw Exception('Ticket not found for PIN: $pin'),
    );
  }

  @override
  Future<List<Location>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('[MockApiClient] getLocations');
    return List.unmodifiable(_locations);
  }

  /// Resolve a location from the static store by ID, with fallback.
  static Map<String, dynamic> _resolveSite(String locationId) {
    final loc = _locations.where((l) => l.id == locationId);
    if (loc.isNotEmpty) {
      return {
        'name': loc.first.name,
        'address': loc.first.address ?? '',
        ...loc.first.rawData,
      };
    }
    return {'name': 'Demo Location', 'address': 'Fort Lauderdale, FL'};
  }

  @override
  Future<CrudResult> createTicket(Ticket data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('[MockApiClient] createTicket');
    _ticketCounter++;
    final ticket = _DemoTicket(
      id: 'demo_ticket_$_ticketCounter',
      ticketNumber: 'TK-${1000 + _ticketCounter}',
      userClientId: data.userClientId,
      vehicleId: data.vehicleId,
      status: 'Parked',
      locationId: data.locationId,
      notes: data.notes,
      pin: '${8000 + _ticketCounter}',
      site: _resolveSite(data.locationId),
      createdAt: DateTime.now().toIso8601String(),
    );
    _tickets.add(ticket);
    _lastTicketCreatedAt = DateTime.now();
    _departureRequestedAt = null; // Reset departure phase for new ticket
    return _successResult({'id': ticket.id, 'pin': ticket.pin});
  }
}
