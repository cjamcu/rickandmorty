import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';

import 'package:rickandmorty/features/episodes/domain/repositories/episodes_repository.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class FindEpisodes
    extends UseCase<GetAllApiResponse<Episode>, FindEpisodesParams> {
  final EpisodesRepository repository;

  FindEpisodes(this.repository);

  @override
  Future<GetAllApiResponse<Episode>> execute(FindEpisodesParams params) async {
    return await repository.findEpisodes(params.page);
  }
}

class FindEpisodesParams {
  final int page;

  const FindEpisodesParams(this.page);
}
