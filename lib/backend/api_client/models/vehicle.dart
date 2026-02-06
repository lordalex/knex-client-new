import '/flutter_flow/flutter_flow_util.dart';

class Vehicle {
  Vehicle({
    this.id,
    required this.userClientId,
    required this.vehicleMake,
    required this.vehicleModel,
    this.vehicleYear,
    required this.licensePlate,
    required this.color,
    this.vin,
  });

  final String? id;
  final String userClientId;
  final String vehicleMake;
  final String vehicleModel;
  final String? vehicleYear;
  final String licensePlate;
  final String color;
  final String? vin;

  factory Vehicle.fromMap(Map<String, dynamic> data) {
    return Vehicle(
      id: data['id'] as String?,
      userClientId: data['user_client_id'] as String,
      vehicleMake: data['vehicle_make'] as String,
      vehicleModel: data['vehicle_model'] as String,
      vehicleYear: data['vehicle_year'] as String?,
      licensePlate: data['license_plate'] as String,
      color: data['color'] as String,
      vin: data['vin'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_client_id': userClientId,
        'vehicle_make': vehicleMake,
        'vehicle_model': vehicleModel,
        'vehicle_year': vehicleYear,
        'license_plate': licensePlate,
        'color': color,
        'vin': vin,
      }.withoutNulls;
}

class VehicleCreation {
  VehicleCreation({
    required this.vehicleMake,
    required this.vehicleModel,
    this.vehicleYear,
    required this.licensePlate,
    required this.color,
    this.vin,
  });

  final String vehicleMake;
  final String vehicleModel;
  final String? vehicleYear;
  final String licensePlate;
  final String color;
  final String? vin;

  factory VehicleCreation.fromMap(Map<String, dynamic> data) {
    return VehicleCreation(
      vehicleMake: data['vehicle_make'] as String,
      vehicleModel: data['vehicle_model'] as String,
      vehicleYear: data['vehicle_year'] as String?,
      licensePlate: data['license_plate'] as String,
      color: data['color'] as String,
      vin: data['vin'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'vehicle_make': vehicleMake,
        'vehicle_model': vehicleModel,
        'vehicle_year': vehicleYear,
        'license_plate': licensePlate,
        'color': color,
        'vin': vin,
      }.withoutNulls;
}
