import 'package:rickandmorty/features/characters/domain/entities/character.dart';

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


