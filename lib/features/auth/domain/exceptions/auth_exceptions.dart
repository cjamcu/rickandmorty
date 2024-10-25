class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException([this.message = 'Credenciales inválidas']);

  @override
  String toString() => 'InvalidCredentialsException: $message';
}

class TooManyRequestsException implements Exception {
  final String message;
  TooManyRequestsException([this.message = 'Demasiadas solicitudes']);

  @override
  String toString() => 'TooManyRequestsException: $message';
}
