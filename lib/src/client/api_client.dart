import 'package:dio/dio.dart';

const apiBaseUrl = String.fromEnvironment("API_BASE_URL", defaultValue: "https://foreclair.tatnux.fr/");

class ApiClient {

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Dio get instance => _dio;
}
