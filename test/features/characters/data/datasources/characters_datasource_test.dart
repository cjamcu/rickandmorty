import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/models/characters_response.dart';
import 'package:rickandmorty/features/characters/domain/exceptions/no_found_characters_exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CharactersDatasourceApi datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = CharactersDatasourceApi(client: mockHttpClient);
  });

  group('getCharacters', () {
    const tPage = 1;
    final tUri =
        Uri.parse('http://rickandmortyapi.com/api/character?page=$tPage');

    test('should return CharactersResponse when the HTTP call is successful',
        () async {
      // Arrange
      when(() => mockHttpClient.get(tUri))
          .thenAnswer((_) async => http.Response(
              json.encode({
                'results': [],
                'info': {'pages': 1, 'count': 1}
              }),
              200));

      // Act
      final result = await datasource.getCharacters(page: tPage);

      // Assert
      expect(result, isA<CharactersResponse>());
      verify(() => mockHttpClient.get(tUri)).called(1);
    });

    test('should throw NotFoundCharactersException when the status code is 404',
        () async {
      // Arrange
      when(() => mockHttpClient.get(tUri))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final call = datasource.getCharacters;

      // Assert
      expect(
          () => call(page: tPage), throwsA(isA<NotFoundCharactersException>()));
    });

    test('should throw Exception when the status code is not 200 or 404',
        () async {
      // Arrange
      when(() => mockHttpClient.get(tUri))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = datasource.getCharacters;

      // Assert
      expect(() => call(page: tPage), throwsA(isA<Exception>()));
    });
  });

  group('CharactersResponse.fromJson', () {
    test('should correctly parse JSON data', () {
      // Arrange
      final jsonData = {
        'info': {
          'count': 826,
          'pages': 42,
          'next': 'https://rickandmortyapi.com/api/character?page=2',
          'prev': null
        },
        'results': [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'origin': {
              'name': 'Earth (C-137)',
              'url': 'https://rickandmortyapi.com/api/location/1'
            },
            'location': {
              'name': 'Citadel of Ricks',
              'url': 'https://rickandmortyapi.com/api/location/3'
            },
            'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            'episode': [
              'https://rickandmortyapi.com/api/episode/1',
              'https://rickandmortyapi.com/api/episode/2',
            ],
            'url': 'https://rickandmortyapi.com/api/character/1',
            'created': '2017-11-04T18:48:46.250Z'
          }
        ]
      };

      // Act
      final result = CharactersResponse.fromJson(jsonData);

      // Assert
      expect(result, isA<CharactersResponse>());
      expect(result.pages, equals(42));
      expect(result.count, equals(826));
      expect(result.results.length, equals(1));
      expect(result.results[0].id, equals(1));
      expect(result.results[0].name, equals('Rick Sanchez'));
      expect(result.results[0].status, equals('Alive'));
      expect(result.results[0].species, equals('Human'));
      expect(result.results[0].gender, equals('Male'));
      expect(result.results[0].origin, equals('Earth (C-137)'));
      expect(result.results[0].image,
          equals('https://rickandmortyapi.com/api/character/avatar/1.jpeg'));
    });
  });
}
