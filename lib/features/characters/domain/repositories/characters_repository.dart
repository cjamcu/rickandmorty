import '../entities/characters_result.dart';

abstract class CharactersRepository {
  Future<CharactersResult> getCharacters({
    required int page,
    String? name,
  });
}
