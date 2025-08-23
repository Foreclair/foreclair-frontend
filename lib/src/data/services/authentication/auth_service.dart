import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foreclair/src/data/models/authentication/auth_result_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../utils/logs/logger_utils.dart';
import '../../../client/api_client.dart';

class AuthKeys {
  static const ACCESS_TOKEN = "access_token";
  static const REFRESH_TOKEN = "refresh_token";
}

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  static AuthService get instance => _instance;

  final Dio _dio = ApiClient.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService._privateConstructor();

  /// Returns the stored access token or refresh it if needed
  Future<String?> getAccessToken() async {
    final accessToken = await _storage.read(key: AuthKeys.ACCESS_TOKEN);

    // Check if the token is still valid
    if (accessToken == null || JwtDecoder.isExpired(accessToken)) {
      return refreshAccessToken();
    }

    return accessToken;
  }

  /// Returns the stored refresh token
  Future<String?> getRefreshToken() async {
    return _storage.read(key: AuthKeys.REFRESH_TOKEN);
  }

  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  /// Stores both access and refresh token to the secure storage
  Future<void> storeTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: AuthKeys.ACCESS_TOKEN, value: accessToken);
    await _storage.write(key: AuthKeys.REFRESH_TOKEN, value: refreshToken);
  }

  /// Delete both access and refresh token from secure storage
  Future<void> disconnect() async {
    await _storage.delete(key: AuthKeys.ACCESS_TOKEN);
    await _storage.delete(key: AuthKeys.REFRESH_TOKEN);
  }

  Future<String?> getUsername() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      return null;
    }

    return JwtDecoder.decode(accessToken)['sub'];
  }

  /// Refresh the access token using the refresh token
  Future<String?> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    // Check if refresh token is valid
    if (refreshToken == null || JwtDecoder.isExpired(refreshToken)) {
      return null;
    }

    final response = await _dio.request(
      '/auth/refresh',
      data: refreshToken,
      options: Options(method: 'POST'),
    );
    if (response.statusCode == 200) {
      // Successful refresh, storing the new tokens
      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];
      await storeTokens(newAccessToken, newRefreshToken);
      return newAccessToken;
    }
    return null;
  }

  /// Tries to login with a username and password
  Future<AuthResult> login(String username, String password) async {
    try {
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      final response = await _dio.post(
        '/auth',
        options: Options(headers: {'Authorization': basicAuth}, validateStatus: (status) => status! < 500),
      );

      switch (response.statusCode) {
        case 200:
          {
            // Successful login
            final String accessToken = response.data['accessToken'];
            final String refreshToken = response.data['refreshToken'];
            logger.i('Successful login for $username');
            await storeTokens(accessToken, refreshToken);
            return AuthResult.success(accessToken);
          }
        case 401:
          {
            // Login failure
            logger.w('Invalid credentials for user: $username');
            return AuthResult.failure(
              'Identifiants incorrects. Veuillez vérifier votre email et mot de passe.',
              AuthErrorType.invalidCredentials,
            );
          }
        default:
          {
            logger.e('Server error: ${response.statusCode}');
            return AuthResult.failure(
              'Erreur serveur (${response.statusCode}). Veuillez réessayer plus tard.',
              AuthErrorType.serverError,
            );
          }
      }
    } on DioException catch (e) {
      logger.e('Network error during login', error: e, stackTrace: StackTrace.current);
      return AuthResult.failure(_getNetworkErrorMessage(e), AuthErrorType.networkError);
    } catch (e) {
      logger.e('Unexpected error during login', error: e, stackTrace: StackTrace.current);
      return AuthResult.failure("Une erreur inattendue s'est produite.", AuthErrorType.unknown);
    }
  }

  String _getNetworkErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Délai d'attente dépassé. Vérifiez votre connexion internet.";
      case DioExceptionType.connectionError:
        return 'Impossible de se connecter au serveur.';
      default:
        return 'Erreur de réseau. Veuillez réessayer.';
    }
  }
}
