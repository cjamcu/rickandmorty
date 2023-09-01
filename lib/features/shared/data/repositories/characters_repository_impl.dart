import 'dart:convert';

import 'package:http/http.dart';

import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_info.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/features/shared/data/models/characters_models.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<CharactersInfo> findCharacters() async {
    final params = {
      'page': '1',
    };
    final uri = Uri.http("rickandmortyapi.com", "/api/character", params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    final charactersResponse = CharactersModel.fromJson(data);

    return CharactersInfo(
      characters: charactersResponse.characters,
      totalPages: charactersResponse.totalPages,
      currentPage: charactersResponse.currentPage,
    );
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
