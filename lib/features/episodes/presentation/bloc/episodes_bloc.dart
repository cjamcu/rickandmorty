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
  }

  Future<FutureOr<void>> _onFindEpisodesEvent(
      FindEpisodesEvent event, Emitter<EpisodesState> emit) async {
    emit(EpisodesLoading(state.model));

    try {
      final findEpisodesResponse =
          await findEpisodes.execute(const FindEpisodesParams());
      emit(EpisodesLoaded(
          state.model.copyWith(episodes: findEpisodesResponse.episodes)));
    } catch (e) {
      emit(EpisodesError(state.model));
    }
  }
}
