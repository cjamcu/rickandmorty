import 'package:rickandmorty/features/characters/domain/entities/characters_info.dart';

abstract class CharactersRepository {
  Future<CharactersInfo> findCharacters();
}
