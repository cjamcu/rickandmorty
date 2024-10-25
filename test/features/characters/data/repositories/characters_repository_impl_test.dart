import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/models/characters_response.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';

class MockCharactersDatasource extends Mock implements CharactersDatasource {}

void main() {
  late CharactersRepositoryImpl repository;
  late MockCharactersDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockCharactersDatasource();
    repository = CharactersRepositoryImpl(charactersDatasource: mockDatasource);
  });

  group('getCharacters', () {
    const tCharactersResponse =
        CharactersResponse(results: [], pages: 1, count: 1);
    const tPage = 1;
    const tName = 'Rick';

    test(
        'should return CharactersResult when the datasource call is successful',
        () async {
      // Arrange
      when(() => mockDatasource.getCharacters(page: tPage, name: tName))
          .thenAnswer((_) async => tCharactersResponse);

      // Act
      final result = await repository.getCharacters(page: tPage, name: tName);

      // Assert
      expect(result, isA<CharactersResult>());
      verify(() => mockDatasource.getCharacters(page: tPage, name: tName))
          .called(1);
    });

    test('should propagate the exception when the datasource call fails',
        () async {
      // Arrange
      when(() => mockDatasource.getCharacters(page: tPage, name: tName))
          .thenThrow(Exception('Error'));

      // Act
      final call = repository.getCharacters;

      // Assert
      expect(() => call(page: tPage, name: tName), throwsA(isA<Exception>()));
    });
  });
}
