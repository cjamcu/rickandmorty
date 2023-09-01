import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_info.dart';

abstract class CharactersRepository {
  Future<CharactersInfo> findCharacters();
  Future<List<Character>> findCharactersByIDs(List<int> characterIds);
}

