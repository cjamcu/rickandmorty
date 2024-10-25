import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/screens/detail_character_screen.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class SearchResultsList extends StatelessWidget {
  final List<Character> characters;

  const SearchResultsList({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            DetailCharacterScreen.route(character, characters),
          ),
          child: _CharacterListItem(character: character),
        );
      },
    );
  }
}

class _CharacterListItem extends StatelessWidget {
  final Character character;

  const _CharacterListItem({required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Hero(
            tag: character.id,
            child: AvatarCached(
              imageUrl: character.image,
              size: 60,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  character.species.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
