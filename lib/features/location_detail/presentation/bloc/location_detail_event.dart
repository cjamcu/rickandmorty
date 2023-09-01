part of 'location_detail_bloc.dart';

abstract class LocationDetailEvent extends Equatable {
  const LocationDetailEvent();
}

class FindCharactersFromLocationEvent extends LocationDetailEvent {
  final List<int> charactersIDs;

  const FindCharactersFromLocationEvent({required this.charactersIDs});

  @override
  List<Object> get props => [charactersIDs];
}
