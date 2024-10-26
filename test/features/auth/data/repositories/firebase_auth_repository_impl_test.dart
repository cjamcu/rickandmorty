import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:rickandmorty/features/auth/data/repositories/firebase_auth_repository_impl.dart';
import 'package:rickandmorty/features/auth/domain/exceptions/auth_exceptions.dart';

class MockAuthDatasource extends Mock implements AuthDatasource {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuthRepositoryImpl repository;
  late MockAuthDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAuthDatasource();
    repository = FirebaseAuthRepositoryImpl(authDatasource: mockDatasource);
  });

  group('signInWithEmailAndPassword', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test('should return UserCredential when sign in is successful', () async {
      // Arrange
      final tUserCredential = MockUserCredential();
      when(() => mockDatasource.signInWithEmailAndPassword(tEmail, tPassword))
          .thenAnswer((_) async => tUserCredential);

      // Act
      final result =
          await repository.signInWithEmailAndPassword(tEmail, tPassword);

      // Assert
      expect(result, equals(tUserCredential));
      verify(() => mockDatasource.signInWithEmailAndPassword(tEmail, tPassword))
          .called(1);
    });

    test(
        'should throw InvalidCredentialsException when credentials are invalid',
        () async {
      // Arrange
      when(() => mockDatasource.signInWithEmailAndPassword(tEmail, tPassword))
          .thenThrow(InvalidCredentialsException());

      // Act
      final call = repository.signInWithEmailAndPassword;

      // Assert
      expect(() => call(tEmail, tPassword),
          throwsA(isA<InvalidCredentialsException>()));
    });

    test(
        'should throw TooManyRequestsException when too many requests are made',
        () async {
      // Arrange
      when(() => mockDatasource.signInWithEmailAndPassword(tEmail, tPassword))
          .thenThrow(TooManyRequestsException());

      // Act
      final call = repository.signInWithEmailAndPassword;

      // Assert
      expect(() => call(tEmail, tPassword),
          throwsA(isA<TooManyRequestsException>()),);
    });
  });

  group('signOut', () {
    test('should call signOut method of datasource', () async {
      // Arrange
      when(() => mockDatasource.signOut()).thenAnswer((_) async {});

      // Act
      await repository.signOut();

      // Assert
      verify(() => mockDatasource.signOut()).called(1);
    });

    test('should propagate exceptions from datasource', () async {
      // Arrange
      when(() => mockDatasource.signOut())
          .thenThrow(Exception('Sign out error'));

      // Act
      final call = repository.signOut;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
