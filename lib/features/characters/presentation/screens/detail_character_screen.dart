import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/providers/detail_character_provider.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_header.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_info.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_badges.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_info_item.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/more_characters_list.dart';

class DetailCharacterScreen extends StatelessWidget {
  final Character character;
  final List<Character> characters;

  const DetailCharacterScreen({
    super.key,
    required this.character,
    required this.characters,
  });

  static Route<dynamic> route(Character character, List<Character> characters) {
    return MaterialPageRoute(
      builder: (context) => DetailCharacterScreen(
        character: character,
        characters: characters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailCharacterProvider(
        repository: CharactersRepositoryImpl(
          charactersDatasource: CharactersDatasourceApi(client: Client()),
        ),
      )..loadEpisode(character.episode),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          primary: true,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 19,
              right: 30.5,
              top: 40,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CharacterHeader(character: character),
                const SizedBox(height: 12),
                CharacterInfo(character: character),
                const SizedBox(height: 12),
                if (character.episode != null)
                  Consumer<DetailCharacterProvider>(
                    builder: (context, provider, child) {
                      switch (provider.state) {
                        case DetailCharacterState.loading:
                          return const CharacterInfoItem(
                            label: 'Episodio',
                            value: 'Cargando...',
                          );
                        case DetailCharacterState.loaded:
                          return CharacterInfoItem(
                            label: 'Episodio',
                            value: provider.episode!.name,
                          );

                        case DetailCharacterState.initial:
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                const SizedBox(height: 16),
                CharacterBadges(character: character),
                const SizedBox(height: 72),
                if (characters.length > 1)
                  Text(
                    'Más personajes',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                if (characters.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: MoreCharactersList(
                      characters: characters,
                      character: character,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
