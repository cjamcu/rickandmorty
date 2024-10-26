import 'package:firebase_auth/firebase_auth.dart';
import 'package:rickandmorty/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:rickandmorty/features/auth/domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  FirebaseAuthRepositoryImpl({required AuthDatasource authDatasource})
      : _authDatasource = authDatasource;

  @override
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    return _authDatasource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() {
    return _authDatasource.signOut();
  }
}
