part of 'characters_by_ids_bloc.dart';

abstract class CharactersByIdsEvent extends Equatable {
  const CharactersByIdsEvent();
}

class FindCharactersFromLocationEvent extends CharactersByIdsEvent {
  final List<int> charactersIDs;

  const FindCharactersFromLocationEvent({required this.charactersIDs});

  @override
  List<Object> get props => [charactersIDs];
}
