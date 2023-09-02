import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

abstract class CharactersRepository {
  Future<GetAllApiResponse<Character>>  findCharacters(int page,String? name);
  Future<List<Character>> findCharactersByIDs(List<int> characterIds);
}

