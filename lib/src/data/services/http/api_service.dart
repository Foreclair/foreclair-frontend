import 'package:dio/dio.dart';
import 'package:foreclair/src/data/services/authentication/auth_service.dart';

import '../../../../utils/logs/logger_utils.dart';
import '../../../client/api_client.dart';
import '../../dao/user_dao.dart';
import '../../models/users/user_model.dart';

class ApiService {
  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService get instance => _instance;

  final AuthService _authService = AuthService.instance;
  final Dio _dio = ApiClient.instance;

  ApiService._privateConstructor();

  Future<Response> request({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool useAuth = true,
  }) async {
    try {
      Options options = Options(method: method);
      if (useAuth) {
        final accessToken = await _authService.getAccessToken();
        if (accessToken != null) {
          options = options.copyWith(headers: {'Authorization': 'Bearer $accessToken'});
        }
      }
      return await _dio.request(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      logger.e('HTTP Error: ${e.message}', error: e, stackTrace: StackTrace.current);
      rethrow;
    }
  }

  Future<Response> get({required String path, dynamic data, Map<String, dynamic>? queryParameters, bool useAuth = true}) {
    return request(method: 'GET', path: path, data: data, queryParameters: queryParameters, useAuth: useAuth);
  }

  Future<Response> post({required String path, dynamic data, Map<String, dynamic>? queryParameters, bool useAuth = true}) {
    return request(method: 'POST', path: path, data: data, queryParameters: queryParameters, useAuth: useAuth);
  }

  /// Initializes the user instance and returns true on success.
  Future<bool> initializeUserInformation({String? username}) async {
    if (UserDao.instance.currentUser != null) {
      return true;
    }

    try {
      final resolvedUsername = username ?? await _authService.getUsername();
      if (resolvedUsername == null) {
        UserDao.instance.currentUser = null;
        return false;
      }

      final userResponse = await get(path: "/users/$resolvedUsername");
      if (userResponse.statusCode == 200 && userResponse.data != null) {
        UserDao.instance.currentUser = UserModel.fromJson(userResponse.data);
        return true;
      } else {
        UserDao.instance.currentUser = null;
        return false;
      }
    } catch (e, st) {
      logger.e('Error retrieving user data: $e', error: e, stackTrace: st);
      UserDao.instance.currentUser = null;
      return false;
    }
  }
}
