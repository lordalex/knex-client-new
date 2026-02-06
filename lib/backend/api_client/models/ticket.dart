import '/backend/api_client/models/vehicle.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ticket {
  Ticket({
    this.id,
    this.ticketNumber,
    required this.userClientId,
    required this.vehicleId,
    required this.status,
    required this.locationId,
    this.notes,
    this.pin,
  });

  final String? id;
  final String? ticketNumber;
  final String userClientId;
  final String vehicleId;
  final String status;
  final String locationId;
  final String? notes;
  final String? pin;

  factory Ticket.fromMap(Map<String, dynamic> data) {
    return Ticket(
      id: data['id'] as String?,
      ticketNumber: data['ticket_number'] as String?,
      userClientId: data['user_client_id'] as String,
      vehicleId: data['vehicle_id'] as String,
      status: data['status'] as String,
      locationId: data['location_id'] as String,
      notes: data['notes'] as String?,
      pin: data['pin'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'ticket_number': ticketNumber,
        'user_client_id': userClientId,
        'vehicle_id': vehicleId,
        'status': status,
        'location_id': locationId,
        'notes': notes,
        'pin': pin,
      }.withoutNulls;
}

class ProvisionalTicket {
  ProvisionalTicket({
    this.id,
    this.pin,
    required this.locationId,
    required this.vehicle,
  });

  final String? id;
  final String? pin;
  final String locationId;
  final VehicleCreation vehicle;

  factory ProvisionalTicket.fromMap(Map<String, dynamic> data) {
    return ProvisionalTicket(
      id: data['id'] as String?,
      pin: data['pin'] as String?,
      locationId: data['location_id'] as String,
      vehicle: VehicleCreation.fromMap(data['vehicle']),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'pin': pin,
        'location_id': locationId,
        'vehicle': vehicle.toMap(),
      }.withoutNulls;
}
