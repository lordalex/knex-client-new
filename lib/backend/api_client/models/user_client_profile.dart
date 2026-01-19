import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserClientProfile {
  UserClientProfile({
    this.id,
    this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.photo,
  });

  final String? id;
  final String? uid;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? photo;

  factory UserClientProfile.fromMap(Map<String, dynamic> data) {
    return UserClientProfile(
      id: data['id'] as String?,
      uid: data['uid'] as String?,
      email: data['email'] as String,
      firstName: (data['firstName'] ?? data['firstname']) as String,
      lastName: (data['lastName'] ?? data['lastname']) as String,
      phoneNumber: (data['phoneNumber'] ?? data['phone']) as String,
      photo: data['photo'] as String?,
      createdAt:
          data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
      updatedAt:
          data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'photo': photo,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      }.withoutNulls;
}
