import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CrudResult {
  CrudResult({
    required this.status,
    this.data,
  });

  final Status status;
  final dynamic data;

  factory CrudResult.fromMap(Map<String, dynamic> data) {
    return CrudResult(
      status: Status.fromMap(data['status']),
      data: data['data'],
    );
  }
}

class Status {
  Status({
    required this.status,
    this.result,
    this.message,
  });

  final String status;
  final String? result;
  final String? message;

  factory Status.fromMap(Map<String, dynamic> data) {
    return Status(
      status: data['status'] as String,
      result: data['result'] as String?,
      message: data['message'] as String?,
    );
  }
}

class Location {
  Location({
    required this.id,
    required this.name,
    this.address,
    this.rawData = const {},
  });

  final String id;
  final String name;
  final String? address;
  final Map<String, dynamic> rawData;

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      address: data['address']?.toString(),
      rawData: data,
    );
  }

  Map<String, dynamic> toMap() {
    return rawData;
  }
}
