import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/models/characters_response.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';
import 'package:rickandmorty/features/characters/data/models/episode_model.dart';
import 'package:rickandmorty/features/characters/domain/entities/episode.dart';

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

  group('getEpisode', () {
    const tEpisodeUrl = 'https://rickandmortyapi.com/api/episode/1';
    const tEpisodeModel = EpisodeModel(
      name: 'Pilot',
    );

    test('should return Episode when the call to datasource is successful',
        () async {
      // arrange
      when(() => mockDatasource.getEpisode(tEpisodeUrl))
          .thenAnswer((_) async => tEpisodeModel);

      // act
      final result = await repository.getEpisode(tEpisodeUrl);

      // assert
      expect(result, isA<Episode>());
      expect(result.name, equals('Pilot'));
      verify(() => mockDatasource.getEpisode(tEpisodeUrl)).called(1);
    });

    test('should throw an exception when the call to datasource fails',
        () async {
      // arrange
      when(() => mockDatasource.getEpisode(tEpisodeUrl)).thenThrow(Exception());

      // act
      final call = repository.getEpisode;

      // assert
      expect(() => call(tEpisodeUrl), throwsException);
      verify(() => mockDatasource.getEpisode(tEpisodeUrl)).called(1);
    });
  });
}
