import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {required int id,
      required String image,
      required String name,
      required String status})
      : super(
          id: id,
          image: image,
          name: name,
          status: status,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
    );
  }
}

class CharactersModel {
  final List<CharacterModel> characters;
  final int totalPages;
  final int currentPage;

  const CharactersModel({
    required this.characters,
    required this.totalPages,
    required this.currentPage,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final characters = (json['results'] as List)
        .map((character) => CharacterModel.fromJson(character))
        .toList();

    return CharactersModel(
      characters: characters,
      totalPages: json['info']['pages'],
      currentPage: json['info']['count'],
    );
  }
}
