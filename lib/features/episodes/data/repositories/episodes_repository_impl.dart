import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/episodes/data/models/episodes_models.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';
import 'package:rickandmorty/features/episodes/domain/repositories/episodes_repository.dart';
import 'package:rickandmorty/features/shared/data/models/get_all_api_model.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  final Client client;

  EpisodesRepositoryImpl(this.client);

  @override
  Future<GetAllApiResponse<Episode>> findEpisodes(int page) async {
    final params = {'page': '$page'};
    final uri = Uri.http("rickandmortyapi.com", "/api/episode", params);
    final response = await client.get(uri);
    final data = json.decode(response.body);

    return GetAllApiModelModel<EpisodeModel>.fromJson(
      data,
      (itemJson) => EpisodeModel.fromJson(itemJson),
    );
  }
}
