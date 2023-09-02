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
          const CharactersInitial(Model(
              characters: [], totalPages: 1, currentPage: 1, totalElements: 1)),
        ) {
    on<FindCharactersEvent>(_onFindCharactersEvent);
    on<FindMoreCharactersEvent>(_onFindMoreCharactersEvent);
  }

  Future<FutureOr<void>> _onFindCharactersEvent(
      FindCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(CharactersLoading(state.model));
    try {
      final response =
          await findCharacters.execute(const FindCharactersParams(1));
      emit(CharactersLoaded(state.model.copyWith(
        characters: response.items,
        totalPages: response.totalPages,
        totalElements: response.totalElements,
      )));
    } catch (e) {
      emit(CharactersError(state.model));
    }
  }

  Future<FutureOr<void>> _onFindMoreCharactersEvent(
      FindMoreCharactersEvent event, Emitter<CharactersState> emit) async {
    if (state.model.currentPage >= state.model.totalPages) {
      return 0;
    }

    emit(CharactersLoadingMore(state.model));
    final currentPage = state.model.currentPage + 1;
    try {
      final response =
          await findCharacters.execute(FindCharactersParams(currentPage));
      emit(CharactersLoaded(state.model.copyWith(
        characters: state.model.characters + response.items,
        totalPages: response.totalPages,
        currentPage: currentPage,
        totalElements: response.totalElements,
      )));
    } catch (e) {
      emit(CharactersError(state.model));
    }
  }
}
