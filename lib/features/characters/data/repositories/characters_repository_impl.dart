import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';
import 'package:rickandmorty/features/characters/domain/entities/episode.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersDatasource charactersDatasource;

  CharactersRepositoryImpl({required this.charactersDatasource});

  @override
  Future<CharactersResult> getCharacters({
    required int page,
    String? name,
  }) async {
    final response = await charactersDatasource.getCharacters(
      page: page,
      name: name,
    );
    return response;
  }

  @override
  Future<Episode> getEpisode(String url) async {
    final response = await charactersDatasource.getEpisode(url);
    return response;
  }
}
