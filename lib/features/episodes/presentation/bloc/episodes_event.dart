part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();
}

class FindEpisodesEvent extends EpisodesEvent {
  const FindEpisodesEvent();

  @override
  List<Object?> get props => [];
}
