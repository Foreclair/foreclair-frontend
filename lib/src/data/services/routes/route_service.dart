import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/logs/logger_utils.dart';
import '../../../client/api_client.dart';

class RouteService {
  final Dio _dio = ApiClient.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

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
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options = options.copyWith(headers: {'Authorization': 'Bearer $token'});
        }
      }
      final response = await _dio.request(path, data: data, queryParameters: queryParameters, options: options);
      return response;
    } on DioException catch (e) {
      logger.e('HTTP Error: ${e.message}', error: e, stackTrace: StackTrace.current);
      rethrow;
    }
  }

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'access_token');
  }
}
