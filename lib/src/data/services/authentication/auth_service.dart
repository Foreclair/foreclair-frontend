// lib/services/auth_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../utils/logs/logger_utils.dart';
import '../../../client/api_client.dart';
import '../../models/authentication/auth_result_model.dart';
import '../routes/route_service.dart';

class AuthService {
  final Dio _dio = ApiClient.instance;
  final RouteService _routeService = RouteService();

  Future<AuthResult> login(String email, String password) async {
    try {
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$email:$password'))}';
      final response = await _dio.post(
        '/auth',
        options: Options(headers: {'Authorization': basicAuth}, validateStatus: (status) => status! < 500),
      );

      if (response.statusCode == 200) {
        final token = response.data.toString();
        await _routeService.storeToken(token);
        logger.i('Login successful for user: $email');
        return AuthResult.success(token);
      } else if (response.statusCode == 401) {
        logger.w('Invalid credentials for user: $email');
        return AuthResult.failure(
          'Identifiants incorrects. Veuillez vérifier votre email et mot de passe.',
          AuthErrorType.invalidCredentials,
        );
      } else {
        logger.e('Server error: ${response.statusCode}');
        return AuthResult.failure(
          'Erreur serveur (${response.statusCode}). Veuillez réessayer plus tard.',
          AuthErrorType.serverError,
        );
      }
    } on DioException catch (e) {
      logger.e('Network error during login', error: e, stackTrace: StackTrace.current);
      return AuthResult.failure(_getNetworkErrorMessage(e), AuthErrorType.networkError);
    } catch (e) {
      logger.e('Unexpected error during login', error: e, stackTrace: StackTrace.current);
      return AuthResult.failure('Une erreur inattendue s\'est produite.', AuthErrorType.unknown);
    }
  }

  String _getNetworkErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Délai d\'attente dépassé. Vérifiez votre connexion internet.';
      case DioExceptionType.connectionError:
        return 'Impossible de se connecter au serveur.';
      default:
        return 'Erreur de réseau. Veuillez réessayer.';
    }
  }
}
