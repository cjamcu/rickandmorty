import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/characters/domain/entities/find_characters_reponse.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

class FindCharacters
    extends UseCase<FindCharactersResponse, FindCharactersParams> {
  final CharactersRepository repository;

  FindCharacters(this.repository);

  @override
  Future<FindCharactersResponse> execute(FindCharactersParams params) async {
    return await repository.findCharacters(params.page);
  }
}

class FindCharactersParams extends Equatable {
  final int page;

  const FindCharactersParams(this.page);

  @override
  List<Object?> get props => [page];
}
