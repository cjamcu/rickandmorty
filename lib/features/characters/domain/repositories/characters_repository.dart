import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/entities/find_characters_reponse.dart';

abstract class CharactersRepository {
  Future<FindCharactersResponse> findCharacters(int page);
  Future<List<Character>> findCharactersByIDs(List<int> characterIds);
}

