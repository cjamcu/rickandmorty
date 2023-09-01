import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/location_detail/domain/usecase/find_characters_by_location.dart';

part 'location_detail_event.dart';

part 'location_detail_state.dart';

class LocationDetailBloc
    extends Bloc<LocationDetailEvent, LocationDetailState> {
  final FindCharactersByLocation findCharactersByLocation;

  LocationDetailBloc(this.findCharactersByLocation)
      : super(const LocationDetailInitial()) {
    on<FindCharactersFromLocationEvent>(_onFindCharactersFromLocationEvent);
  }

  Future<FutureOr<void>> _onFindCharactersFromLocationEvent(
      FindCharactersFromLocationEvent event,
      Emitter<LocationDetailState> emit) async {
    emit(LoadingCharactersState(state.characters));

    try {
      final characters = await findCharactersByLocation
          .execute(FindCharactersByLocationParams(event.charactersIDs));
      emit(LoadedCharactersState(characters));
    } catch (e) {
      emit(ErrorLoadingCharactersState(state.characters));
    }
  }
}
