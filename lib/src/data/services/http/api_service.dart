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

  /// GET request method
  Future<Response> get({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool useAuth = true,
  }) async {
    return request(
      method: 'GET',
      path: path,
      data: data,
      queryParameters: queryParameters,
      useAuth: useAuth,
    );
  }

  /// POST request method
  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool useAuth = true,
  }) async {
    return request(
      method: 'POST',
      path: path,
      data: data,
      queryParameters: queryParameters,
      useAuth: useAuth,
    );
  }

  /// Create and send an http request
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
          options = options.copyWith(
            headers: {'Authorization': 'Bearer $accessToken'},
          );
        }
      }
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      logger.e(
        'HTTP Error: ${e.message}',
        error: e,
        stackTrace: StackTrace.current,
      );
      rethrow;
    }
  }

  // Initializes the user instance
  Future<void> initializeUserInformation() async {
    final username = await _authService.getUsername();
    await request(method: "GET", path: "/users/$username")
        .then((userResponse) {
          UserDao.instance.currentUser = UserModel.fromJson(userResponse.data);
          logger.i(
            'Login successful for user: ${UserDao.instance.currentUser.firstName} ${UserDao.instance.currentUser.lastName}',
            stackTrace: StackTrace.empty,
          );
        })
        .catchError((error) {
          logger.e('Error retrieving user data: $error');
        });
  }
}
