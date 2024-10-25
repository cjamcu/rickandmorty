import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:rickandmorty/features/auth/domain/exceptions/auth_exceptions.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late FirebaseAuthDatasource authDatasource;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authDatasource = FirebaseAuthDatasource(firebaseAuth: mockFirebaseAuth);
  });

  group('signInWithEmailAndPassword', () {
    test('should return UserCredential when sign in is successful', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      final mockUserCredential = MockUserCredential();
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password)).thenAnswer((_) async => mockUserCredential);

      // Act
      final result =
          await authDatasource.signInWithEmailAndPassword(email, password);

      // Assert
      expect(result, isA<UserCredential>());
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).called(1);
    });

    test(
        'should throw InvalidCredentialsException when credentials are invalid',
        () async {
      // Arrange
      const email = 'invalid@example.com';
      const password = 'wrongpassword';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).thenThrow(
        FirebaseAuthException(code: 'invalid-credential'),
      );

      // Act
      final call = authDatasource.signInWithEmailAndPassword;

      // Assert
      expect(() => call(email, password),
          throwsA(isA<InvalidCredentialsException>()));
    });

    test(
        'should throw TooManyRequestsException when too many requests are made',
        () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).thenThrow(
        FirebaseAuthException(code: 'too-many-requests'),
      );

      // Act
      final call = authDatasource.signInWithEmailAndPassword;

      // Assert
      expect(() => call(email, password),
          throwsA(isA<TooManyRequestsException>()));
    });

    test(
        'should throw Exception when a FirebaseAuthException unknown error occurs',
        () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).thenThrow(
        FirebaseAuthException(code: 'unknown-error'),
      );

      // Act
      final call = authDatasource.signInWithEmailAndPassword;

      // Assert
      expect(() => call(email, password), throwsA(isA<Exception>()));
    });

    //Exception
    test('should throw Exception when an unknown error occurs', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).thenThrow(
        Exception(),
      );

      // Act
      final call = authDatasource.signInWithEmailAndPassword;

      // Assert
      expect(() => call(email, password), throwsA(isA<Exception>()));
    });
    //
  });

  group('signOut', () {
    test('should sign out the user successfully', () async {
      // Arrange
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      // Act
      await authDatasource.signOut();

      // Assert
      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}

class MockUserCredential extends Mock implements UserCredential {}
