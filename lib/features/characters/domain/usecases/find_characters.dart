import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_info.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

class FindCharacters extends UseCase<CharactersInfo, FindCharactersParams> {
  final CharactersRepository repository;

  FindCharacters(this.repository);

  @override
  Future<CharactersInfo> execute(FindCharactersParams params) async {
    return await repository.findCharacters();
  }
}

class FindCharactersParams extends Equatable {
  const FindCharactersParams();

  @override
  List<Object?> get props => [];
}
