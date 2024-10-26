import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String passwor,
  );
  Future<void> signOut();
}
