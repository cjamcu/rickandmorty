import 'dart:convert';

import 'package:http/http.dart';

import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/features/shared/data/models/character_models.dart';
import 'package:rickandmorty/features/shared/data/models/get_all_api_model.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<GetAllApiResponse<Character>> findCharacters(int page) async {
    final params = {
      'page': '$page'
    };
    final uri = Uri.http("rickandmortyapi.com", "/api/character", params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    return GetAllApiModelModel<CharacterModel>.fromJson(
      data,
          (itemJson) => CharacterModel.fromJson(itemJson),
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
