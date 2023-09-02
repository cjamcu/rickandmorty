import 'dart:convert';

import 'package:http/http.dart';

import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/entities/find_characters_reponse.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/features/shared/data/models/characters_models.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<FindCharactersResponse> findCharacters(int page) async {
    final params = {
      'page': '$page'
    };
    final uri = Uri.http("rickandmortyapi.com", "/api/character", params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    return CharactersModel.fromJson(data);
  }

  @override
  Future<List<Character>> findCharactersByIDs(List<int> characterIds) async {
    final ids = characterIds.join(',');
    final uri = Uri.http("rickandmortyapi.com", "/api/character/$ids");
    final response = await client.get(uri);
    final data = json.decode(response.body);

    final charactersResponse = characterIds.length <= 1
        ? [CharacterModel.fromJson(data)]
        : (data as List)
            .map((characterJson) => CharacterModel.fromJson(characterJson))
            .toList();

    return charactersResponse;
  }
}
