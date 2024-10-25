import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/features/characters/data/models/characters_response.dart';
import 'package:rickandmorty/features/characters/data/models/episode_model.dart';
import 'package:rickandmorty/features/characters/domain/exceptions/no_found_characters_exceptions.dart';

abstract class CharactersDatasource {
  Future<CharactersResponse> getCharacters({
    required int page,
    String? name,
  });

  Future<EpisodeModel> getEpisode(String url);
}

class CharactersDatasourceApi implements CharactersDatasource {
  final http.Client client;

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

  @override
  Future<EpisodeModel> getEpisode(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load episode');
    }

    final data = json.decode(response.body);
    return EpisodeModel.fromJson(data);
  }
}
