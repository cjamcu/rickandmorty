import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/episodes/data/models/episodes_models.dart';
import 'package:rickandmorty/features/episodes/domain/entities/find_episodes_response.dart';
import 'package:rickandmorty/features/episodes/domain/repositories/episodes_repository.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  final Client client;

  EpisodesRepositoryImpl(this.client);

  @override
  Future<FindEpisodesResponse> findEpisodes() async {
    final uri = Uri.http("rickandmortyapi.com", "/api/episode");
    final response = await client.get(uri);
    final data = json.decode(response.body);

    final episodesResponse = EpisodesModel.fromJson(data);

    return FindEpisodesResponse(
       episodesResponse.episodes,
    );
  }
}
