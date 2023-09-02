part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();
}

class FindEpisodesEvent extends EpisodesEvent {
  const FindEpisodesEvent();

  @override
  List<Object?> get props => [];
}

class FindMoreEpisodesEvent extends EpisodesEvent {
  const FindMoreEpisodesEvent();

  @override
  List<Object?> get props => [];
}
