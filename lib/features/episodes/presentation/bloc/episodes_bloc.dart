import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';
import 'package:rickandmorty/features/episodes/domain/usecases/find_episodies.dart';

part 'episodes_event.dart';

part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final FindEpisodes findEpisodes;

  EpisodesBloc(this.findEpisodes) : super(const EpisodesInitial()) {
    on<FindEpisodesEvent>(_onFindEpisodesEvent);
    on<FindMoreEpisodesEvent>(_onFindMoreEpisodesEvent);
  }

  Future<FutureOr<void>> _onFindEpisodesEvent(
      FindEpisodesEvent event, Emitter<EpisodesState> emit) async {
    emit(EpisodesLoading(state.model));

    try {
      final findEpisodesResponse =
          await findEpisodes.execute(const FindEpisodesParams(1));
      emit(EpisodesLoaded(state.model.copyWith(
        episodes: findEpisodesResponse.items,
        totalElements: findEpisodesResponse.totalElements,
        totalPages: findEpisodesResponse.totalPages,
      )));
    } catch (e) {
      emit(EpisodesError(state.model));
    }
  }

  Future<FutureOr<void>> _onFindMoreEpisodesEvent(
      FindMoreEpisodesEvent event, Emitter<EpisodesState> emit) async {

    if (state.model.currentPage >= state.model.totalPages) {
      return 0;
    }
    emit(EpisodesMoreLoading(state.model));
    final currentPage = state.model.currentPage + 1;
    try {
      final findEpisodesResponse =
          await findEpisodes.execute(FindEpisodesParams(currentPage));
      emit(EpisodesLoaded(state.model.copyWith(
        episodes: findEpisodesResponse.items + state.model.episodes,
        totalElements: findEpisodesResponse.totalElements,
        totalPages: findEpisodesResponse.totalPages,
        currentPage: currentPage,
      )));
    } catch (e) {
      emit(EpisodesError(state.model));
    }
  }
}
