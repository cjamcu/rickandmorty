import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';

class FindEpisodesResponse extends Equatable {
  final List<Episode> episodes;

  const FindEpisodesResponse(this.episodes);

  @override
  List<Object?> get props => [episodes];
}
