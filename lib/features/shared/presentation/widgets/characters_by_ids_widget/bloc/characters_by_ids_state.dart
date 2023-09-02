part of 'characters_by_ids_bloc.dart';

abstract class CharactersByIdsState extends Equatable {
  final List<Character> characters;

  const CharactersByIdsState(this.characters);

  @override
  List<Object> get props => [characters];
}

class LocationDetailInitial extends CharactersByIdsState {
  const LocationDetailInitial() : super(const []);
}

class LoadingCharactersState extends CharactersByIdsState {
  const LoadingCharactersState(List<Character> characters)
      : super(characters);
}

class LoadedCharactersState extends CharactersByIdsState {
  const LoadedCharactersState(List<Character> characters)
      : super(characters);
}

class ErrorLoadingCharactersState extends CharactersByIdsState {
  const ErrorLoadingCharactersState(
    List<Character> characters,
  ) : super(characters);
}
