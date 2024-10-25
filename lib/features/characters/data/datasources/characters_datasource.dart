import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/characters/data/models/characters_response.dart';
import 'package:rickandmorty/features/characters/domain/exceptions/no_found_characters_exceptions.dart';

abstract class CharactersDatasource {
  Future<CharactersResponse> getCharacters({
    required int page,
    String? name,
  });
}

class CharactersDatasourceApi implements CharactersDatasource {
  final Client client;

  CharactersDatasourceApi({required this.client});

  @override
  Future<CharactersResponse> getCharacters({
    required int page,
    String? name,
  }) async {
    final params = {
      'page': '$page',
      if ((name ?? '').isNotEmpty) 'name': name,
    };
    final uri = Uri.http("rickandmortyapi.com", "/api/character", params);

    final response = await client.get(uri);

    if (response.statusCode == 404) {
      throw NotFoundCharactersException();
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to load characters');
    }
    final data = json.decode(response.body);
    return CharactersResponse.fromJson(data);
  }
}
