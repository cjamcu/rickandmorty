import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/entities/find_characters_reponse.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {required int id,
      required String image,
      required String name,
      required String status,
      required String species,
      required String gender})
      : super(
          id: id,
          image: image,
          name: name,
          status: status,
          species: species,
          gender: gender,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
    );
  }
}

class CharactersModel extends FindCharactersResponse {
  final List<CharacterModel> results;
  final int pages;
  final int count;

  const CharactersModel({
    required this.results,
    required this.pages,
    required this.count,
  }) : super(
          totalElements: count,
          totalPages: pages,
          characters: results,
        );

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((character) => CharacterModel.fromJson(character))
        .toList();

    return CharactersModel(
      results: results,
      pages: json['info']['pages'],
      count: json['info']['count'],
    );
  }
}
