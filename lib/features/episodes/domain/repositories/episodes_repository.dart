import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';

import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

abstract class EpisodesRepository {
  Future<GetAllApiResponse<Episode>> findEpisodes(int page);
}
