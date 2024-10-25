class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException([this.message = 'Credenciales inválidas']);
}

class TooManyRequestsException implements Exception {
  final String message;
  TooManyRequestsException([this.message = 'Demasiadas solicitudes']);
}
