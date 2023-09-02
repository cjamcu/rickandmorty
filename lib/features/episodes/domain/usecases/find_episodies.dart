import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/episodes/domain/entities/find_episodes_response.dart';
import 'package:rickandmorty/features/episodes/domain/repositories/episodes_repository.dart';

class FindEpisodes extends UseCase<FindEpisodesResponse, FindEpisodesParams> {
  final EpisodesRepository repository;

  FindEpisodes(this.repository);

  @override
  Future<FindEpisodesResponse> execute(FindEpisodesParams params) async {
    return await repository.findEpisodes();
  }
}

class FindEpisodesParams {
  const FindEpisodesParams();
}
