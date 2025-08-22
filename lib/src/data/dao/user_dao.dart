import 'package:foreclair/src/data/models/sector/sector_model.dart';
import 'package:foreclair/src/data/models/station/station_model.dart';
import 'package:foreclair/src/data/models/users/user_model.dart';

class UserDao {
  static UserDao? _instance = UserDao._internal();

  static UserDao get instance => _instance ??= UserDao._internal();

  UserDao._internal();

  UserModel currentUser = UserModel(
    id: '0',
    firstName: 'error',
    lastName: 'login',
    username: 'error.login',
    role: 'ERROR',
    sector: Sector(id: '0', location: 123, name: "error sector", stations: []),
    station: Station(id: '0', location: 123, name: "error station"),
  );
}
