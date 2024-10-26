import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';
import 'package:rickandmorty/features/characters/domain/entities/episode.dart';

abstract class CharactersRepository {
  Future<CharactersResult> getCharacters({
    required int page,
    String? name,
  });

  Future<Episode> getEpisode(String url);
}
