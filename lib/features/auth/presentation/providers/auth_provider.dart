import 'package:flutter/material.dart';
import 'package:rickandmorty/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:rickandmorty/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  invalidCredentials,
  tooManyRequests
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;

  AuthStatus _status = AuthStatus.initial;
  AuthStatus get status => _status;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();

      await _authRepository.signInWithEmailAndPassword(email, password);
      _status = AuthStatus.authenticated;
    } on InvalidCredentialsException {
      _status = AuthStatus.invalidCredentials;
    } on TooManyRequestsException {
      _status = AuthStatus.tooManyRequests;
    } catch (e) {
      _status = AuthStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
