import 'package:rickandmorty/features/characters/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({required super.name});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(name: json['name']);
  }
}
