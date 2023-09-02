part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class FindCharactersEvent extends CharactersEvent {
  const FindCharactersEvent();

  @override
  List<Object?> get props => [];
}

class FindMoreCharactersEvent extends CharactersEvent {
  const FindMoreCharactersEvent();

  @override
  List<Object?> get props => [];
}

class SearchCharacterByNameEvent extends CharactersEvent {
  final String name;

  const SearchCharacterByNameEvent(this.name);

  @override
  List<Object?> get props => [];
}
