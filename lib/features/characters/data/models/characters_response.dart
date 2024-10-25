import 'package:rickandmorty/features/characters/data/models/character_model.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';

class CharactersResponse extends CharactersResult {
  const CharactersResponse({
    required super.results,
    required super.pages,
    required super.count,
  });

  factory CharactersResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final results = (json['results'] as List)
        .map((item) => CharacterModel.fromJson(item))
        .toList();

    return CharactersResponse(
      results: results,
      pages: json['info']['pages'],
      count: json['info']['count'],
    );
  }
}
