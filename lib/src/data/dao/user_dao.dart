import 'package:foreclair/src/data/models/users/user_model.dart';

class UserDao {
  static UserDao? _instance;

  static UserDao get instance => _instance ??= UserDao._internal();

  UserDao._internal();

  UserModel? currentUser;

  bool get hasUser => currentUser != null;

  UserModel get requireUser {
    if (currentUser == null) {
      throw StateError('No user is currently set in UserDao');
    }
    return currentUser!;
  }
}
