import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class FindCharacters
    extends UseCase<GetAllApiResponse<Character>, FindCharactersParams> {
  final CharactersRepository repository;

  FindCharacters(this.repository);

  @override
  Future<GetAllApiResponse<Character>> execute(
      FindCharactersParams params) async {
    return await repository.findCharacters(params.page);
  }
}

class FindCharactersParams extends Equatable {
  final int page;

  const FindCharactersParams(this.page);

  @override
  List<Object?> get props => [page];
}
