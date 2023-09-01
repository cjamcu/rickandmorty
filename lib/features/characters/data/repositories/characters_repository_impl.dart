import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/characters/data/models/characters_models.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_info.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<CharactersInfo> findCharacters() async {
    final params = {
      'page': '1',
    };
    final Uri uri = Uri.http("rickandmortyapi.com", "/api/character", params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    final charactersResponse = CharactersModel.fromJson(data);

    return CharactersInfo(
      characters: charactersResponse.characters,
      totalPages: charactersResponse.totalPages,
      currentPage: charactersResponse.currentPage,
    );
  }
}
