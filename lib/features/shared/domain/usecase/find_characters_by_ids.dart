import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

class FindCharactersByIds
    implements UseCase<List<Character>, FindCharactersByLocationParams> {
  final CharactersRepository repository;

  FindCharactersByIds(this.repository);

  @override
  Future<List<Character>> execute(FindCharactersByLocationParams params) {
    return params.characterIds.isNotEmpty
        ? repository.findCharactersByIDs(params.characterIds)
        : Future.value([]);
  }
}

class FindCharactersByLocationParams {
  final List<int> characterIds;

  FindCharactersByLocationParams(this.characterIds);
}
