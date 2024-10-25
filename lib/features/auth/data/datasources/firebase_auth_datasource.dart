import 'package:firebase_auth/firebase_auth.dart';
import 'package:rickandmorty/features/auth/domain/exceptions/auth_exceptions.dart';

abstract class AuthDatasource {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
}

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDatasource({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw InvalidCredentialsException();
      } else if (e.code == 'too-many-requests') {
        throw TooManyRequestsException();
      }
      throw Exception('Error al iniciar sesión: ${e.toString()}');
    } catch (e) {
      throw Exception('Error al iniciar sesión: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
