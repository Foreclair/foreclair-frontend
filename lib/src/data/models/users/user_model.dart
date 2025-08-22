import 'package:foreclair/src/data/models/sector/sector_model.dart';
import 'package:foreclair/src/data/models/station/station_model.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String role;
  final Sector sector;
  final Station station;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.role,
    required this.sector,
    required this.station,
  });

  static UserModel fromJson(data) {
    return UserModel(
      id: data['id'] ?? '0',
      firstName: data['firstname'] ?? '',
      lastName: data['lastname'] ?? '',
      username: data['username'] ?? '',
      role: data['role'] ?? '',
      sector: Sector.fromJson(data['sector']),
      station: Station.fromJson(data['station']),
    );
  }
}
