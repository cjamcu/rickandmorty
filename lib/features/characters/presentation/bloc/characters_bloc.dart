import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/usecases/find_characters.dart';

part 'characters_event.dart';

part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final FindCharacters findCharacters;

  CharactersBloc(this.findCharacters)
      : super(
          const CharactersInitial(
              Model(characters: [], totalPages: 1, currentPage: 1)),
        ) {
    on<FindCharactersEvent>(_onFindCharactersEvent);
  }

  Future<FutureOr<void>> _onFindCharactersEvent(
      FindCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(CharactersLoading(state.model));
    try {
      final charactersInfo =
          await findCharacters.execute(const FindCharactersParams());
      emit(CharactersLoaded(Model(
          characters: charactersInfo.characters,
          totalPages: charactersInfo.totalPages,
          currentPage: charactersInfo.currentPage)));
    } catch (e) {
      emit(CharactersError(state.model));
    }
  }
}
