class AuthResult {
  final bool isSuccess;
  final String? token;
  final String? errorMessage;
  final AuthErrorType? errorType;

  AuthResult.success(this.token) : isSuccess = true, errorMessage = null, errorType = null;

  AuthResult.failure(this.errorMessage, this.errorType) : isSuccess = false, token = null;
}

enum AuthErrorType { invalidCredentials, networkError, serverError, unknown }
