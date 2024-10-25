import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.image,
    required super.name,
    required super.status,
    required super.species,
    required super.gender,
    required super.origin,
    required super.created,
    super.episode,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final origin = OriginModel.fromJson(json['origin']);
    final episodes = json['episode'] as List<dynamic>;
    return CharacterModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: origin.name.replaceAll(' (Replacement Dimension)', ''),
      created: json['created'],
      episode: episodes.isNotEmpty ? episodes.first : null,
    );
  }
}

class OriginModel {
  final String name;

  const OriginModel({
    required this.name,
  });

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(
      name: json['name'],
    );
  }
}
