part of 'location_detail_bloc.dart';

abstract class LocationDetailState extends Equatable {
  final List<Character> characters;

  const LocationDetailState(this.characters);

  @override
  List<Object> get props => [characters];
}

class LocationDetailInitial extends LocationDetailState {
  const LocationDetailInitial() : super(const []);
}

class LoadingCharactersState extends LocationDetailState {
  const LoadingCharactersState(List<Character> characters)
      : super(characters);
}

class LoadedCharactersState extends LocationDetailState {
  const LoadedCharactersState(List<Character> characters)
      : super(characters);
}

class ErrorLoadingCharactersState extends LocationDetailState {
  const ErrorLoadingCharactersState(
    List<Character> characters,
  ) : super(characters);
}
