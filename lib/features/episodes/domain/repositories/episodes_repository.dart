import 'package:rickandmorty/features/episodes/domain/entities/find_episodes_response.dart';

abstract class EpisodesRepository {
  Future<FindEpisodesResponse> findEpisodes();
}