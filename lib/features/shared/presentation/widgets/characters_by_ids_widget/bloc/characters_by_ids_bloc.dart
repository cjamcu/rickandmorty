import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/domain/usecase/find_characters_by_ids.dart';


part 'characters_by_ids_event.dart';

part 'characters_by_ids_state.dart';

class CharactersByIdsBloc
    extends Bloc<CharactersByIdsEvent, CharactersByIdsState> {
  final FindCharactersByIds findCharactersByLocation;

  CharactersByIdsBloc(this.findCharactersByLocation)
      : super(const LocationDetailInitial()) {
    on<FindCharactersFromLocationEvent>(_onFindCharactersFromLocationEvent);
  }

  Future<FutureOr<void>> _onFindCharactersFromLocationEvent(
      FindCharactersFromLocationEvent event,
      Emitter<CharactersByIdsState> emit) async {
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
