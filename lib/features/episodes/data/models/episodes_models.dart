//
// {
// "info": {
// "count": 51,
// "pages": 3,
// "next": "https://rickandmortyapi.com/api/episode?page=2",
// "prev": null
// },
// "results": [
// {
// "id": 1,
// "name": "Pilot",
// "air_date": "December 2, 2013",
// "episode": "S01E01",
// "characters": [
// "https://rickandmortyapi.com/api/character/1",
// "https://rickandmortyapi.com/api/character/2",
// //...
// ],
// "url": "https://rickandmortyapi.com/api/episode/1",
// "created": "2017-11-10T12:56:33.798Z"
// },
// // ...
// ]
// }

import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel(
      {required super.id,
      required super.name,
      required super.airDate,
      required super.episode,
      required super.charactersIds});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    List<String> characters = List<String>.from(json['characters'] as List);

    final charactersIds =
        characters.map((e) => int.parse(e.split('/').last)).toList();

    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      charactersIds: charactersIds,
    );
  }
}


class EpisodesModel {
  final List<EpisodeModel> episodes;
  final int totalPages;

  EpisodesModel({
    required this.episodes,
    required this.totalPages,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    final episodes = results.map((e) {
      return EpisodeModel.fromJson(e);
    }).toList();

    return EpisodesModel(
      episodes: episodes,
      totalPages: json['info']['pages'] ?? 0,
    );
  }
}
